import 'dart:convert';
import 'package:crud_api/ui/berandauser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
//import package
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usr = new TextEditingController();
  TextEditingController psw = new TextEditingController();
  String msg = "";
  Future<List> _login() async {
    final response = await http
        .post("http://192.168.43.27/apiflutter/Login/login_api", body: {
      "username": usr.text,
      "password": psw.text,
    });
    var datauser = json.decode(response.body);
    if (datauser["error"] == true) {
      setState(() {
        msg = datauser["msg"];
      });
    } else {
      String emailAPI = datauser["email"];
      String namaAPI = datauser["nama"];
      String id = datauser["id"];
      String photo = datauser["photo"];
      int level = int.parse(datauser["level"]);
      setState(() {
        savePref(emailAPI, namaAPI, id, level, photo);
      });
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Berandauser()));
    }
  }

  savePref(
      String email, String nama, String id, int level, String photo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("nama", nama);
      preferences.setString("email", email);
      preferences.setString("id", id);
      preferences.setString("photo", photo);
      preferences.setInt("level", level);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/appimages/bglogin.jpg"),
                fit: BoxFit.cover)),
        child: ListView(children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 5)),
          Image.asset("assets/appimages/login.png", width: 30),
          Container(
            padding: EdgeInsets.all(8),
            child: TextField(
                controller: usr,
                decoration: InputDecoration(
                  fillColor: (Colors.white),
                  hintText: "Username",
                  labelText: "Username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                )),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
                obscureText: true,
                controller: psw,
                decoration: InputDecoration(
                  fillColor: (Colors.white),
                  hintText: "Password",
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                )),
          ),
          RaisedButton(
            child: Row(
                children: <Widget>[Icon(Icons.verified_user), Text("LOGIN")]),
            color: Colors.blue,
            onPressed: () {
              _login();
            },
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Register()));
            },
            child: Text(
              'Create New Account',
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            msg,
            style: TextStyle(fontSize: 20.0, color: Colors.red),
          )
        ]),
      ),
    );
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email, password, username, nama;
  String pesan = "";
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    final response = await http
        .post("http://192.168.43.27/apiflutter/Login/register", body: {
      "username": username,
      "password": password,
      "email": email,
      "nama": nama
    });
    var data = jsonDecode(response.body);
    //int value = data['value'];
    // ignore: unrelated_type_equality_checks
    if (data["error"] == true) {
      setState(() {
        pesan = data["message"];
      });
    } else {
      setState(() {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Masukan Nama Lengkap";
                      }
                    },
                    onSaved: (e) => nama = e,
                    decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  // ignore: missing_return
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Masukan Email";
                    }
                  },
                  onSaved: (e) => email = e,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  // ignore: missing_return
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Masukan Username";
                    }
                  },
                  onSaved: (e) => username = e,
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: _secureText,
                  onSaved: (e) => password = e,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0)),
                    suffixIcon: IconButton(
                        icon: Icon(_secureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: showHide),
                  ),
                ),
              ),
              MaterialButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                onPressed: () {
                  check();
                },
                child: Text(
                  "Register",
                  textScaleFactor: 1.5,
                ),
              ),
              Text(
                pesan,
                style: TextStyle(fontSize: 20.0, color: Colors.red),
              )
            ],
          ),
        ));
  }
}
