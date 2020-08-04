import 'package:flutter/material.dart';
import 'package:push_app/src/providers/push_notifications_provider.dart';
import 'package:push_app/src/views/home_page.dart';
import 'package:push_app/src/views/mensaje_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {

  


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //estado actual del Navigator, por que dentro del listen no hace un pushname por que aun no se crean 
  // los routes
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  // este key nos permite tener la referencia al navigator

  @override
  void initState() { 
    super.initState();
    
    final pushProvider = new PushNotificationsProvider();
    pushProvider.initNotifications();

    pushProvider.getmensajesStream.listen((event) {
      print('argumento main: $event');

      // Navigator.pushNamed(context, 'mensaje');
      navigatorKey.currentState.pushNamed('mensaje', arguments: event);

    });
  } 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home'    : (BuildContext context) => HomePage(),
        'mensaje' : (BuildContext context) => MensajePage(),
      },
    );
  }
}