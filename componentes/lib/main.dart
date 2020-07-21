import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'package:componentes/src/routes/routes.dart';

//  class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//      return super.createHttpClient(context)
//        ..findProxy = (uri) {
//          return "PROXY 192.168.43.96:9999;";
//        }
//        ..badCertificateCallback =
//          (X509Certificate cert, String host, int port) => true;
//    }
// }



void main() { 
  // HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp()); }
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English, no country code
        const Locale('es', 'ES'), // Hebrew, no country code
        const Locale.fromSubtags(languageCode: 'zh'), // Chinese *See Advanced Locales below*
        // ... other locales the app supports
      ],
      title: 'Componentes App',
      // home: HomePageTemp()
      // home: HomePage(),
      initialRoute: '/',
      routes: getAplicacionRoutes() ,


      // routes: <String, WidgetBuilder> {
      //   '/'       : (BuildContext context) => HomePage(),
      //   'alert'   : (BuildContext context) => AlertPage(),
      //   'avatar'  : (BuildContext context) => AvatarPage()
        
      // } ,
      // onGenerateRoute: (RouteSettings settings) {

      //   print('Ruta llamada ${settings.name}');

      //   return MaterialPageRoute(
      //     builder: (BuildContext context) =>AlertPage()
          
      //   );

      // } ,

      );
  }
}