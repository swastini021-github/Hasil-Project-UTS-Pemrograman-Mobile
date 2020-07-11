import 'package:crud_api/ui/berandaadmin.dart';
import 'package:crud_api/ui/berandauser.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class TambahProduk extends StatelessWidget {
  final list;
  final index;
  TambahProduk({this.list, this.index});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: index == null ? "Input Produk Baru" : "Update Produk",
      home: Scaffold(
        appBar: AppBar(
          title: index == null ? Text("Input Produk") : Text("Update Update"),
        ),
        body: MyCustomForm(
          list: list,
          index: index,
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  final list;
  final index;
  MyCustomForm({this.list, this.index});
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  Future<http.Response> adddata(index) async {
    if (index == null) {
      final http.Response response = await http
          .post("http://192.168.43.27/apiflutter/admin/save_produk", body: {
        'nama_produk': namaController.text,
        'quantity': quantityController.text,
        'deskripsi': deskripsiController.text,
        'harga': hargaController.text,
        'photo': photoController.text,
      });
      return response;
    } else {
      final http.Response response = await http.post(
          "http://192.168.43.27/apiflutter/admin/save_update_produk",
          body: {
            'id_produk': widget.list['id_produk'],
            'nama_produk': namaController.text,
            'quantity': quantityController.text,
            'deskripsi': deskripsiController.text,
            'harga': hargaController.text,
            'photo': photoController.text,
          });
      return response;
    }
  }

  @override
  void initState() {
    if (widget.index == null) {
      namaController = TextEditingController();
      quantityController = TextEditingController();
      deskripsiController = TextEditingController();
      hargaController = TextEditingController();
      photoController = TextEditingController();
    } else {
      namaController = TextEditingController(text: widget.list['nama_produk']);
      quantityController = TextEditingController(text: widget.list['quantity']);
      deskripsiController =
          TextEditingController(text: widget.list['deskripsi']);
      photoController = TextEditingController(text: widget.list['image']);
      hargaController = TextEditingController(text: widget.list['harga']);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Masukan Nama Barang';
                  }
                  return null;
                },
                controller: namaController,
                decoration: InputDecoration(
                  labelText: "Nama Barang",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: deskripsiController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Masukan Deskripsi Barang';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Deskripsi",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                )),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Stok",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0)),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Mohon Isi dengan angka';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: hargaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Harga(RP)",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0)),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Mohon Isi dengan angka';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Masukan Nama File';
                  }
                  return null;
                },
                controller: photoController,
                decoration: InputDecoration(
                  labelText: "Nama Photo",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                )),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      "Simpan",
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        adddata(widget.index);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new Berandauser()));
                      }
                    },
                  ),
                ),
                Container(
                  width: 5.0,
                ),
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      "Batal",
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new Berandauser()));
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
