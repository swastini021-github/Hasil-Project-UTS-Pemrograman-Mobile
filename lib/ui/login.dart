import 'dart:convert';
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
  Future<String> _login() async {
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
        SavePref(emailAPI, namaAPI, id, level, photo);
      });
    }
  }

  SavePref(
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
          Padding(padding: EdgeInsets.only(top: 30)),
          Image.asset("assets/appimages/login.png", width: 100),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
                controller: usr,
                decoration: InputDecoration(
                  hintText: "Username",
                  labelText: "Username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                )),
            color: Colors.white,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
                obscureText: true,
                controller: psw,
                decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                )),
            color: Colors.white,
          ),
          RaisedButton(
            child: Row(
                children: <Widget>[Icon(Icons.verified_user), Text("LOGIN")]),
            color: Colors.blue,
            onPressed: () {
              _login();
            },
          ),
          Text(msg)
        ]),
      ),
    );
  }
}
