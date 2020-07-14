

import 'package:flutter/material.dart';
import 'package:holamundo/src/pages/Home_page.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Material App',
      home: Center(
        // child: Text('Hola Mundo')
        child: HomePage(),
      )
    );

    

  }
}