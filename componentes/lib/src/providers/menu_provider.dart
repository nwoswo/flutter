
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle ;

class _MenuProvider {

  List<dynamic> opciones = [];

  _MenuProvider() {
    // cargarData();
  }

  // cargarData() async {
  Future<List<dynamic>> cargarData() async {

    // rootBundle.loadString('data/menu_opts.json').then((data ) => 
    //   print(data)
    //  );

    final data2 = await rootBundle.loadString('data/menu_opts.json');

    // print(data2);
    //Convertir json to String

    Map dataMap = json.decode(data2);
    // print(dataMap);
    opciones = dataMap['rutas'];
    // print(opciones);
    return opciones;

  }


  

}


final menuProvider = new _MenuProvider();

