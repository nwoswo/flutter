import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider_inhered.dart';
import 'package:formvalidation/src/views/home_page.dart';
import 'package:formvalidation/src/views/login_page.dart';
import 'package:formvalidation/src/views/producto_page.dart';
import 'package:formvalidation/src/views/registro_page.dart';

import 'src/preferencias_usuario/preferencias_usuario.dart';
 
void main() async {

  //TODO shared_preferences 
  //registra en el local storage
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final pref = new PreferenciasUsuario();
    // print(pref.token);
    return ProviderIngered(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login'     : (BuildContext context) => LoginPage(),
          'home'      : (BuildContext context) => HomePage(),
          'producto'  : (BuildContext context) => ProductoPage(),
          'registro'  : (BuildContext context) => RegistroPage(),
        },
        //TODO Theme Color purple
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      )
    );

     
  }
}