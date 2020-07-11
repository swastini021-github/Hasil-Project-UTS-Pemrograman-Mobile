import 'dart:convert';
import 'package:crud_api/ui/tambah_produk.dart';
import 'package:flutter/material.dart';
import './detail_produk.dart';
import 'package:crud_api/modal/api.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class DaftarProduk extends StatefulWidget {
  @override
  _ListProdukState createState() => _ListProdukState();
}

class _ListProdukState extends State<DaftarProduk> {
  List produkList;
  int count = 0;
  Future<List> getData() async {
    final response = await http.get(BaseUrl.tampilProduk);
    return json.decode(response.body);
  }

  @override
  void initState() {
    Future<List> produkListFuture = getData();
    produkListFuture.then((produkList) {
      setState(() {
        this.produkList = produkList;
        this.count = produkList.length;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("List Produk"),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: 'Input Barang',
          onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new TambahProduk(
                    list: null,
                    index: null,
                  )))),
    );
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            color: Colors.white,
            margin: EdgeInsets.all(2),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => DetailProduk(
                    name: produkList[index]['nama_produk'],
                    description: produkList[index]['deskripsi'],
                    price: produkList[index]['harga'],
                    image: produkList[index]['image'],
                    stok: produkList[index]['quantity'],
                    star: 4,
                  ),
                ));
              },
              subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset(
                      "assets/appimages/" + produkList[index]['image'],
                      width: 150,
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(this.produkList[index]['nama_produk'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text(this.produkList[index]['deskripsi']),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                size: 10,
                                color: Colors.deepOrange,
                              ),
                              Icon(
                                Icons.star,
                                size: 10,
                                color: Colors.deepOrange,
                              ),
                              Icon(
                                Icons.star,
                                size: 10,
                                color: Colors.deepOrange,
                              ),
                              Icon(Icons.star, size: 10, color: Colors.orange),
                              Text(
                                " | Rp. " + produkList[index]['harga'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(children: <Widget>[
                            new Text(
                              " Stok " + produkList[index]['quantity'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                          Row(
                            children: <Widget>[
                              new GestureDetector(
                                  child: Icon(Icons.update),
                                  onTap: () => Navigator.of(context)
                                      .pushReplacement(new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new TambahProduk(
                                                list: produkList[index],
                                                index: index,
                                              )))),
                              new GestureDetector(
                                child: Icon(Icons.delete),
                                onTap: () => confirm(
                                    produkList[index]['id_produk'],
                                    produkList[index]['nama_produk']),
                              )
                            ],
                          )
                        ],
                      ),
                    ))
                  ]),
            ));
      },
    );
  }

  Future<http.Response> deleteProduk(id) async {
    final http.Response response = await http
        .delete('http://192.168.43.27/apiflutter/admin/delete_produk/$id');
    return response;
  }

  void confirm(id, nama) {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Anda yakin hapus penjualan '$nama'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "OK Hapus!",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
            deleteProduk(id);
            Navigator.of(context, rootNavigator: true).pop();
            initState();
          },
        ),
        new RaisedButton(
          child: new Text("Batal", style: new TextStyle(color: Colors.black)),
          color: Colors.green,
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ],
    );
    showDialog(context: context, child: alertDialog);
  }
}
