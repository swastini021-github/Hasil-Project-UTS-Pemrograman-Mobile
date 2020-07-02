import 'package:crud_api/ui/berandaadmin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart' as http;
import './listpenjualan.dart';
import 'dart:async';

class InputUsers extends StatelessWidget {
  final list;
  final index;
  //class constructor
  InputUsers({this.list, this.index});
  @override
  Widget build(BuildContext context) {
    //membuat material app
    return MaterialApp(
      //menampilkan judul transaksi baru jika index null
      title: index == null ? "User Baru" : "Update User",
      home: Scaffold(
        appBar: AppBar(
          title: index == null ? Text("User Baru") : Text("Update User"),
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
  //membaca inputan dari textfield
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Future<http.Response> adddata(index) async {
    if (index == null) {
      final http.Response response = await http
          .post("http://192.168.43.27/apiflutter/admin/save_users", body: {
        'nama': nameController.text,
        'emali': emailController.text,
        'username': usernameController.text,
        'password': passwordController.text,
        'password': photoController.text,
      });
      return response;
    } else {
      final http.Response response = await http.post(
          "http://192.168.43.27/apiflutter/admin/save_update_users",
          body: {
            'id': widget.list['id'],
            'nama': nameController.text,
            'email': emailController.text,
            'username': usernameController.text,
            'password': passwordController.text,
            'password': photoController.text,
          });
      return response;
    }
  }

  @override
  void initState() {
    if (widget.index == null) {
      nameController = TextEditingController();
      usernameController = TextEditingController();
      passwordController = TextEditingController();
      emailController = TextEditingController();
      photoController = TextEditingController();
    } else {
      //jika index tidak null
      nameController = TextEditingController(text: widget.list['nama']);
      usernameController = TextEditingController(text: widget.list['username']);
      passwordController = TextEditingController(text: widget.list['password']);
      photoController = TextEditingController(text: widget.list['photo']);
      emailController = TextEditingController(text: widget.list['email']);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _secureText = true;
    showHide() {
      setState(() {
        _secureText = !_secureText;
      });
    }

    //membuat form sesuai _formkey
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
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Mohon isi dengan Email';
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Mohon masukan username';
                  }
                  return null;
                },
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passwordController,
              obscureText: _secureText,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0)),
                suffixIcon: IconButton(
                    icon: Icon(
                        _secureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: showHide),
              ),
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
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Nama File(Photo)",
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
                                builder: (context) => new Berandaadmin()));
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
                              builder: (context) => new Berandaadmin()));
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
