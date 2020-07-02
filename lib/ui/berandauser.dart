import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './berandaadmin.dart' as berandaadmin;
import './detail_akun.dart';
import './homeusr.dart' as homeusr;
import './listproduk.dart' as listproduk;
import './listpenjualan.dart' as listpenjualan;
import './inputpenjualan.dart' as inputpenjualan;
import './product.dart' as produk;
import './login.dart';

class Berandauser extends StatefulWidget {
  @override
  _BerandauserState createState() => _BerandauserState();
}

class _BerandauserState extends State<Berandauser>
    with SingleTickerProviderStateMixin {
  TabController controller;
  @override
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
        return Scaffold(
            //widget Drawer
            drawer: new Drawer(
              child: new ListView(
                children: <Widget>[
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
                              AssetImage('assets/appimages/' + photo),
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
                ],
              ),
            ),
            body: new TabBarView(
              controller: controller,
              children: <Widget>[
                new berandaadmin.Berandaadmin(),
                new produk.DaftarProduk(),
                new listpenjualan.ListPenjualan(),
              ],
            ),
            bottomNavigationBar: new Material(
              color: Colors.blue,
              child: new TabBar(
                controller: controller,
                tabs: <Widget>[
                  new Tab(icon: new Icon(Icons.home)),
                  new Tab(icon: new Icon(Icons.view_list)),
                  new Tab(icon: new Icon(Icons.shopping_cart))
                ],
              ),
            ));
        break;
      case 2:
        return Scaffold(
            //widget Drawer
            drawer: new Drawer(
              child: new ListView(
                children: <Widget>[
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
                              AssetImage('assets/appimages/' + photo),
                        ),
                      ),
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
                ],
              ),
            ),
            body: new TabBarView(
              controller: controller,
              children: <Widget>[
                new homeusr.MyHomePage(),
                new listproduk.ListProduk(),
                new inputpenjualan.InputPenjualan(),
              ],
            ),
            bottomNavigationBar: new Material(
              color: Colors.blue,
              child: new TabBar(
                controller: controller,
                tabs: <Widget>[
                  new Tab(icon: new Icon(Icons.home)),
                  new Tab(icon: new Icon(Icons.view_list)),
                  new Tab(icon: new Icon(Icons.input))
                ],
              ),
            ));
        break;
      default:
        return Login();
    }
  }
}
