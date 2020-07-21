import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {


  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {

  double _valorSlider =100.0;
  bool _bloquearCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slider'),
      ),

      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            _crearSlider(),
            _chekBox(),
            _crearSwitch(),
            Expanded(child: _crearImagen()),
          ],
        ),
      ),
    );
  }

  Widget _crearSlider() {
    return Slider(

      activeColor: Colors.indigo,
      label: 'Tamanho de la imagen',
      // divisions: 20,

      min: 10.0,
      max: 400.0,
      value: _valorSlider, 
      onChanged: (_bloquearCheck )? null : (valor) {
        setState( () {
          _valorSlider = valor;
        });
      }
    );
  }

  Widget _crearImagen() {
    return Image(
      image: AssetImage('assets/wazon.png'),
      width: _valorSlider,
      fit: BoxFit.contain
    );
  }

  // Widget _chekBox() {
  //   return Checkbox(
  //       value: _bloquearCheck, 
  //       onChanged: (valor) {
  //         setState(() {
  //           _bloquearCheck =  valor;
  //         });
          
  //       }
  //     );
  // }

    Widget _chekBox() {
      return  CheckboxListTile(
        title: Text('Bloquear slider'),
        value: _bloquearCheck, 
        onChanged: (valor) {
          setState(() {
            _bloquearCheck =  valor;
          });
        }
      );
    }

  _crearSwitch() {
    return  SwitchListTile(
      title: Text('Bloquear slider'),
      value: _bloquearCheck, 
      onChanged: (valor) {
        setState(() {
          _bloquearCheck =  valor;
        });
      }
    );
  }
  
}