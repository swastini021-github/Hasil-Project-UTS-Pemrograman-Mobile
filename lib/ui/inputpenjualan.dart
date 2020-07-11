import 'package:crud_api/modal/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart' as http;
import './listpenjualan.dart';
import 'dart:async';

class InputPenjualan extends StatelessWidget {
  final list;
  final index;
  //class constructor
  InputPenjualan({this.list, this.index});
  @override
  Widget build(BuildContext context) {
    //membuat material app
    return MaterialApp(
      //menampilkan judul transaksi baru jika index null
      title: index == null ? "Transaksi Baru" : "Update Transaksi",
      home: Scaffold(
        appBar: AppBar(
          title:
              index == null ? Text("Transaksi Baru") : Text("Update Transaksi"),
        ),
        //membuat body dalamsebuah class dengan parameter list dan index
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
  TextEditingController nameController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  final format = DateFormat('yyyy-MM-dd');
  Future<http.Response> adddata(index) async {
    if (index == null) {
      final http.Response response =
          await http.post(BaseUrl.inputPenjualan, body: {
        'nama': nameController.text,
        'keterangan': keteranganController.text,
        'jumlah': jumlahController.text,
        'tanggal': tanggalController.text,
      });
      return response;
    } else {
      final http.Response response =
          await http.post(BaseUrl.inputPenjualan, body: {
        'id': widget.list['id'],
        'nama': nameController.text,
        'keterangan': keteranganController.text,
        'jumlah': jumlahController.text,
        'tanggal': tanggalController.text,
      });
      return response;
    }
  }

  @override
  void initState() {
    if (widget.index == null) {
      nameController = TextEditingController();
      jumlahController = TextEditingController();
      tanggalController = TextEditingController();
      keteranganController = TextEditingController();
    } else {
      //jika index tidak null
      nameController = TextEditingController(text: widget.list['nama']);
      jumlahController = TextEditingController(text: widget.list['jumlah']);
      tanggalController = TextEditingController(text: widget.list['tanggal']);
      keteranganController =
          TextEditingController(text: widget.list['keterangan']);
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
                    return 'Mohon isi Nama Lengkap';
                  }
                  return null;
                },
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "nama",
                  labelText: "Nama Barang",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                )),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: jumlahController,
              //textfield type number
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "jumlah",
                labelText: "Harga Barang",
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
              controller: keteranganController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "keterangan",
                labelText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0)),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Mohon Isi dengan email';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                //widget DateTimeField terdapat pada package datetime_picker_formfield
                DateTimeField(
                  controller: tanggalController,
                  format: format,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        //setting datepicker
                        context: context,
                        firstDate: DateTime(2020),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2045));
                  },
                  decoration: InputDecoration(
                    hintText: "tanggal",
                    labelText: "Tanggal",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0)),
                  ),
                  validator: (DateTime dateTime) {
                    if (dateTime == null) {
                      return "Mohon diisi tanggal";
                    }
                    return null;
                  },
                )
              ],
            ),
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
                                builder: (context) => new ListPenjualan()));
                      }
                    },
                  ),
                ),
                Container(
                  width: 5.0,
                ),
                Expanded(
                  //untuk batal
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      "Batal",
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      //batal, kembali ke halaman Main dart
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new ListPenjualan()));
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
