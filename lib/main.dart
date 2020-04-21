import  'package:flutter/material.dart';
//import  halaman  yang  akan  diload  kemudian  beri  alias 
import  './ui/home.dart'  as  beranda;
import  './ui/listproduk.dart'  as  listproduk;

//Top  Level/Root 
void  main()  {
//harus  menggunakan  MaterialApp 
runApp(new  MaterialApp(
title:  "tab  Bar", 
home:    new  MyApp(),
));
}
//jangan  lupa  menggunakan  StatefulWidget 
class  MyApp  extends  StatefulWidget  {
@override
_MyAppState  createState()  =>  _MyAppState();
}
//jangan  lupa  panggil  juga  SingleTickerProviderStateMixin
class  _MyAppState  extends  State<MyApp>  with  SingleTickerProviderStateMixin  {
//ini  variabel  controller  untuk  mengatur  tabbar 
TabController  controller;
//jangan  lupa  tambahkan  initState  untuk  inisialisasi  dan  mengaktifkan  tab 
@override
void  initState(){
controller  =  new  TabController(vsync:  this,length:  2); super.initState();
}
//jangan  lupa  tambahkan  dispose  untuk  berpindah  halaman 
@override
void  dispose(){ controller.dispose(); super.dispose();
}
@override
Widget  build(BuildContext  context)  {
//gunakan  widget  Scaffold 
return  Scaffold(
//widget  TabBarView 
body:  new  TabBarView(
//terdapat  controller  untuk  mengatur  halaman 
controller:  controller,
children:  <Widget>[
//pemanggilan  halaman  dimulai  dari  alias.className  halaman  yang  diload 
new  beranda.Home(),
new  listproduk.MyHomePage(),
],
),
//membuat  bottom  tab 
bottomNavigationBar:  new  Material( color:  Colors.blue,
child:  new    TabBar( controller:  controller, tabs:  <Widget>[
//menggunakan  icon  untuk  mempercantik  nama  tab
//icon  berurutan  sesuai  pemanggilan  halaman 
new  Tab(icon:  new  Icon(Icons.home)),
new  Tab(icon:  new  Icon(Icons.list))
],
),)
);
}}
