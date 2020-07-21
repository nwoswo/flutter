import 'package:flutter/material.dart';

class ContadorPage extends StatefulWidget {
  // ContadorPage({Key key}) : super(key: key);

  // @override
  // _ContadorPageState createState() => _ContadorPageState();

  @override
  createState() {
    return new _ContadorPageState();
  }
}

class _ContadorPageState extends State<ContadorPage> {

  final _myestiloTexto = TextStyle( fontSize: 25 );
  int _conteo = 10;

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('StateFul') ,
        centerTitle: true,
      ),
      body: Center(
        // child: Text('Numero de Clicks'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: <Widget>[
          
            Text('Numero de Clicks', style: _myestiloTexto ),
            Text('$_conteo' ,style: _myestiloTexto) 
        ],

        )
      ),

      
      floatingActionButton: _crearBotones(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }




  Widget _crearBotones() {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox( width: 5.0, ),
          FloatingActionButton( onPressed: _reset , child: Icon(Icons.exposure_zero)),
          Expanded(child: SizedBox()),
          FloatingActionButton( onPressed: _sustraer, child: Icon(Icons.remove)),
          SizedBox( width: 5.0, ),
          FloatingActionButton( onPressed: _agregar, child: Icon(Icons.add)),
          SizedBox( width: 5.0, ),
        ],
      );
    
  }

  void _agregar(){
    setState(() =>  _conteo++ );
  }

  void _sustraer(){
    setState(() => _conteo-- );
  }

  void _reset() {
    setState(() => _conteo = 0 );
  }
}