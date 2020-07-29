import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrscaner/src/pages/home_page.dart';
import 'package:qrscaner/src/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRReader',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'mapa': (BuildContext context) => MapaPage()
      },
      //TODO-THEME Main
      theme: ThemeData(
        primaryColor: Colors.red
      ),
    );
  }
}