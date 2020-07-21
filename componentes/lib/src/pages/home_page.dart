



import 'package:flutter/material.dart';
//////////////


import 'package:componentes/src/utils/icono_string_util.dart';
import 'package:componentes/src/providers/menu_provider.dart';


class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),
      body: _lista(),
    );
  }













  Widget _lista() {
    // print(menuProvider.opciones);

    //No podemos usar esta tecnica para cargar por que parecera que esta cargando y demora


    // menuProvider.cargarData().then((opciones) {
    //   print('_lista');
    //   print(opciones);
    // }
    //   return ListView(
    //   // children: <Widget>[],
    //   children: _listaItems(),
    // );
    // );

    //Usaremos un Future Builder
    //puede dibujarse a si mismo basado en el ultimo snapshot que interactuo con el Future

   return  FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder:  (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        // print('builder');
        // print(snapshot.data);

        return ListView(
          // children: <Widget>[],
          children: _listaItems(snapshot.data,context),
        ); 

      },
    );
    
  }

  List <Widget>_listaItems(List<dynamic> data,BuildContext context) {

    

    final List<Widget> opciones = [];

    data.forEach((element) { 

      final widgetTemp = ListTile(
        title: Text( element['texto'] ),
        leading: getIcon(element['icon']),
        trailing: Icon( Icons.keyboard_arrow_right, color: Colors.blue, ),
        onTap: () {

          Navigator.pushNamed(context, element['ruta']);


          //Rutas

          // final route = MaterialPageRoute(
          //   builder: (context) =>  AlertPage() 
          // );


          // Navigator.push(context, route);
        },
      );

      opciones..add(widgetTemp)
              ..add(Divider());

    });

    return opciones;
  }
}