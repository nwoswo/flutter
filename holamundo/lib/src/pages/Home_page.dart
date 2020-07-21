import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  final myestiloTexto = TextStyle( fontSize: 25 );
  final int conteo = 10;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Titulo') ,
        centerTitle: true,
      ),
      body: Center(
        // child: Text('Numero de Clicks'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: <Widget>[
          
            Text('Numero de Clicks', style: myestiloTexto ),
            Text('$conteo' ,style: myestiloTexto) 
        ],

        )
      ),
      floatingActionButton: FloatingActionButton(
        
        child: Icon(Icons.add) ,
        onPressed: () {
          print('Hola Mundo');
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}