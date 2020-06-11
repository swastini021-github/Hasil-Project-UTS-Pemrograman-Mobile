import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './berandaadmin.dart';
import './detail_akun.dart';
import './homeusr.dart' as homeusr;
import './listproduk.dart' as listproduk;
import './listpenjualan.dart' as listpenjualan;
import './detail_produk.dart';
import './login.dart';

class Berandauser extends StatefulWidget {
  @override
  _BerandauserState createState() => _BerandauserState();
}

class _BerandauserState extends State<Berandauser>
    with SingleTickerProviderStateMixin {
  TabController controller;
//jangan  lupa  tambahkan  initState  untuk  inisialisasi  dan  mengaktifkan  tab
  @override

//jangan  lupa  tambahkan  dispose  untuk  berpindah  halaman
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String id, nama, email, photo;
  int level = 0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      level = preferences.getInt("level");
      id = preferences.getString("id");
      nama = preferences.getString("nama");
      email = preferences.getString("email");
      photo = preferences.getString("photo");
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("level", 0);
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 3);
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (level) {
      case 1:
        return Berandaadmin();
        break;
      case 2:
        return Scaffold(
            //widget Drawer
            drawer: new Drawer(
              //menggunakan listView agar drawer dapat melebihi width devices
              child: new ListView(
                children: <Widget>[
                  //Drawer Header diisi dengan informasi akun
                  new GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => DetailAkun(
                          accountName: nama,
                          accountEmail: email,
                          backgroundImage: photo,
                        ),
                      ));
                    },
                    child: UserAccountsDrawerHeader(
                      accountName: new Text(nama),
                      accountEmail: new Text(email),
                      currentAccountPicture: new GestureDetector(
                        onTap: () {},
                        child: new CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/appimages/rara.jpg'),
                        ),
                      ),
                      //memberi background pada Drawer Header
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/appimages/bg.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  //Menu Drawer
                  new ListTile(
                    title: new Text('logout'),
                    trailing: new Icon(Icons.settings),
                    onTap: () {
                      signOut();
                    },
                  ),
                  new ListTile(
                    title: new Text('Notifications'),
                    trailing: new Icon(Icons.notifications_none),
                  ),

                  //Divider Menu
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
            body: new TabBarView(
//terdapat  controller  untuk  mengatur  halaman
              controller: controller,
              children: <Widget>[
//pemanggilan  halaman  dimulai  dari  alias.className  halaman  yang  diload
                new homeusr.MyHomePage(),
                new listproduk.MyHomePage(),
                new listpenjualan.ListPenjualan(),
              ],
            ),
//membuat  bottom  tab
            bottomNavigationBar: new Material(
              color: Colors.blue,
              child: new TabBar(
                controller: controller,
                tabs: <Widget>[
//menggunakan  icon  untuk  mempercantik  nama  tab
//icon  berurutan  sesuai  pemanggilan  halaman
                  new Tab(icon: new Icon(Icons.home)),
                  new Tab(icon: new Icon(Icons.view_list)),
                  new Tab(icon: new Icon(Icons.shopping_cart))
                ],
              ),
            ));
        break;
      default:
        return Login();
    }
  }
}
