import 'dart:convert';
import 'package:crud_api/ui/inputusers.dart';
import 'package:crud_api/ui/tampil_user.dart';
import 'package:flutter/material.dart';
import 'package:crud_api/modal/api.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Berandaadmin extends StatefulWidget {
  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<Berandaadmin> {
  List usersList;
  int count = 0;
  Future<List> getData() async {
    final response = await http.get(BaseUrl.tampilUsers);
    return json.decode(response.body);
  }

  @override
  void initState() {
    Future<List> usersListFuture = getData();
    usersListFuture.then((usersList) {
      setState(() {
        this.usersList = usersList;
        this.count = usersList.length;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Daftar Users"),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: 'Input Barang',
          onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new InputUsers(
                    list: null,
                    index: null,
                  )))),
    );
  }

  ListView createListView() {
    //TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            color: Colors.white,
            margin: EdgeInsets.all(2),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => TampilDetail(
                    name: usersList[index]['nama'],
                    email: usersList[index]['email'],
                    username: usersList[index]['username'],
                    level: usersList[index]['level'],
                    status: usersList[index]['status'],
                    cratedDate: usersList[index]['createdDate'],
                    image: usersList[index]['photo'],
                  ),
                ));
              },
              subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset(
                      "assets/appimages/" + usersList[index]['photo'],
                      width: 150,
                      height: 100,
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(this.usersList[index]['nama'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text(this.usersList[index]['email']),
                          Row(
                            children: <Widget>[
                              new GestureDetector(
                                  child: Icon(Icons.update),
                                  onTap: () => Navigator.of(context)
                                      .pushReplacement(new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new InputUsers(
                                                list: usersList[index],
                                                index: index,
                                              )))),
                              new GestureDetector(
                                child: Icon(Icons.delete),
                                onTap: () => confirm(usersList[index]['id'],
                                    usersList[index]['nama']),
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

  Future<http.Response> deleteUsers(id) async {
    final http.Response response = await http
        .delete('http://192.168.43.27/apiflutter/admin/delete_users/$id');
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
            deleteUsers(id);
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
