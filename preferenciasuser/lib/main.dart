import 'package:flutter/material.dart';
import 'package:preferenciasuser/src/share_prefs/preferencias_usuario.dart';
import 'package:preferenciasuser/src/views/home_page.dart';
import 'package:preferenciasuser/src/views/settings_page.dart';
 
void main() async {

  //TODO  preferencias Main Load
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new Preferenciasusuario();
  await prefs.initPrefs();



  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {

 final prefs = new Preferenciasusuario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Preferencias',
      initialRoute: prefs.ultimaPagina,
      routes: {
        HomePage.routeName     : (BuildContext context) => HomePage(),
        SettingsPage.routeName : (BuildContext context) => SettingsPage(),
      },
    );
  }
}