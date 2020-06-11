import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './detail_akun.dart';
import './login.dart';

class Berandaadmin extends StatefulWidget {
  @override
  _BerandaadminState createState() => _BerandaadminState();
}

class _BerandaadminState extends State<Berandaadmin> {
  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("level", 0);
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beranda Admin"),
      ),
      drawer: new Drawer(
//menggunakan  listView  agar  drawer  dapat  melebihi  width  devices
        child: new ListView(
          children: <Widget>[
//Drawer  Header  diisi  dengan  informasi  akun
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => DetailAkun(
                    accountName: "Putu Swastini",
                    accountEmail: "swastini@undiksha.ac.id",
                    backgroundImage: "swastini.jpg",
                  ),
                ));
              },
              child: UserAccountsDrawerHeader(
                accountName: new Text("Putu Swastini"),
                accountEmail: new Text("swastini@undiksha.ac.id"),
                currentAccountPicture: new GestureDetector(
                  onTap: () {},
                  child: new CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/appimages/swastini.jpg'),
                  ),
                ),
//memberi  background  pada  Drawer  Header
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/appimages/bg.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
//Menu  Drawer
            new ListTile(
              title: new Text('logout'),
              trailing: new Icon(Icons.settings),
              onTap: () {
                signOut();
              },
            ),
//Divider  Menu
            /* Divider(
              height: 2,
            ),

            new ListTile(
              title: new Text('Setting'),
              trailing: new Icon(Icons.settings),
            ),*/
          ],
        ),
      ),
      body: Center(
        child: Text("Ini Beranda Admin"),
      ),
    );
  }
}
