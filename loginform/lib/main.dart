import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/views/home_page.dart';
import 'package:formvalidation/src/views/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'home'  : (BuildContext context) => HomePage(),
        },
        //TODO Theme Color purple
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      )
    );

     
  }
}