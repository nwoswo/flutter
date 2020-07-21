import 'package:flutter/material.dart';

class HomePageTemp  extends StatelessWidget {

  final opciones = ['Uno','Dos','Tres','Cuatro'];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes Temp')
      ),
      body: ListView(
        // children:_crearItems(),
        children: _crearItemsCorta()
      )
    );
  }

  // List<Widget> _crearItems() {

  //   List<Widget> lista = new List<Widget>();

  //   for (String item in opciones) {
      
  //     final temWidget = ListTile(
  //       title: Text( item )
  //     );

  //     lista..add(temWidget)
  //          ..add(Divider());
  //     // lista.add(temWidget);
  //     // lista.add(Divider());

  //   }

  //   return lista;
  // }

  List<Widget> _crearItemsCorta() {

    return opciones.map(  (item) =>

      Column(
        children: <Widget>[
          ListTile(
            
            title: Text( item+'!'),
            subtitle: Text('Cualquier cosa'),
            leading: Icon(Icons.add_shopping_cart),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider()
        ],
      )

    ).toList();

    

  }

  //   List<Widget> _crearItemsCorta() {

  //   return  opciones.map(  (item) {

  //     return ListTile(
  //       title: Text( item+'!'),
  //     );

  //   } ).toList();

    

  // }

}