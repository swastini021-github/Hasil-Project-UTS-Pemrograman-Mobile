import 'package:flutter/material.dart';

class TampilDetail extends StatefulWidget {
  TampilDetail({
    Key key,
    this.name,
    this.email,
    this.username,
    this.level,
    this.status,
    this.image,
    this.cratedDate,
  }) : super(key: key);
  String name;
  final String email;
  final String username;
  final String level;
  final String status;
  final String image;
  final String cratedDate;

  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<TampilDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.name}"),
      ),
      body: new Container(
        width: double.infinity,
        child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Image.asset("assets/appimages/" + widget.image)
              ],
            ),
            Container(
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
                ),
              ),
              padding: EdgeInsets.all(10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[],
              ),
            ),
            Container(
                padding: EdgeInsets.all(10),
                color: Colors.lightBlue,
                width: double.infinity,
                height: double.maxFinite,
                child: new Column(
                  children: <Widget>[
                    Text("Email :" + widget.email,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      "Username :" + widget.username,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Tanggal Buat :" + widget.cratedDate,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Level :" + widget.level,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Status :" + widget.status,
                      textAlign: TextAlign.left,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
