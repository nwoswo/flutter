import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class BotonesPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
            children: <Widget>[
               _titulos(),
               _botonesRedondeados()
            ],
            ),
          )
        ],
      ),
      bottomNavigationBar : _bottomNavigationBar(context)
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem> [

      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.calendar_today),
      //       title: Container()
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.pie_chart_outlined),
      //       title: Container()
      //     ),

      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.supervised_user_circle),
      //       title: Container()
      //     ),


      //   ]
      // ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return new Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(55,57,84,1.0),
        primaryColor: Colors.pinkAccent,

        //estos son los colores de gris claros de los botones que no son seleccionados
        textTheme: Theme.of(context).textTheme.copyWith(
          caption: TextStyle( color: Color.fromRGBO(116,117,152,1.0) )
        )
      ),
      child: BottomNavigationBar(
        items: [

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 30.0),
            title: Container()
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart, size: 30.0),
            title: Container()
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle, size: 30.0),
            title: Container()
          ),


        ],
      ),
    );
  }

  Widget _titulos() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Classify transaction', style: TextStyle(
                color: Colors.white, 
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              )
            ),
          SizedBox(height: 10.0,),
          Text('Classify this transaction into a particular category', style: TextStyle(
                color: Colors.white, 
                fontSize: 18.0,
              )
            ),
        ],
      )
    );
  }


  Widget _fondoApp() {

    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
         gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0)
          ]
        ),
      ),
    );

    final cajaRosaIn = Transform.rotate(
       angle: -pi/5.0,
       child: Container(
        height: 360.0,
        width: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          color: Colors.pink,
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(236,09,188,1.0),
              Color.fromRGBO(241,142,172,1.0)
            ]
          )
        ),
    ),
     );


    final cajaRosa = Positioned(
        top: -100,
        child: cajaRosaIn
    );
    
    

    return Stack(
      children: <Widget>[
       gradiente,
       cajaRosa

      ],
    );
  }

  Widget _botonesRedondeados(){
    return Table(
      children: [
        TableRow(
          children: [
            _crearBotonRedondeado( Colors.blue, Icons.border_all,'General'),
            _crearBotonRedondeado( Colors.red, Icons.dashboard,'Bus' ),
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado( Colors.cyanAccent, Icons.access_alarm,'Alarma' ),
            _crearBotonRedondeado(Colors.green, Icons.calendar_today,'Calendario'),
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado( Colors.pinkAccent, Icons.pie_chart_outlined,'Reporte' ),
            _crearBotonRedondeado( Colors.tealAccent, Icons.tab,'Tabla' ),
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado( Colors.yellow, Icons.youtube_searched_for,'Videos' ),
            _crearBotonRedondeado( Colors.lightBlue, Icons.label_important,'Importante' ),
          ]
        )
      ],
    );
  }

  //   Widget _crearBotonRedondeado(Color color,IconData icono,String texto){
  //   return Container(
  //     margin: EdgeInsets.all(10.0),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(20),
  //       child: BackdropFilter(
  //         filter: ImageFilter.blur( sigmaX: 10, sigmaY: 10),
  //         child: Container(
  //           height: 180.0,
  //           decoration: BoxDecoration(
  //             color: Color.fromRGBO(62, 66, 107, 0.7),
  //           ),child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: <Widget>[
  //               CircleAvatar(
  //                 radius: 35.0,
  //                 backgroundColor: color,
  //                 child: Icon( icono, color: Colors.white, size: 30.0,),
  //               ),
  //               Text(texto, style: TextStyle(color: color)),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  

  Widget _crearBotonRedondeado(Color color, IconData icono, String texto) {

    return Container(
      margin: EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),

        // aplica el blur al fondo pero no al hijo
        child: BackdropFilter(
          filter: ImageFilter.blur( sigmaX: 10.0, sigmaY: 10.0 ),
          child: Container(
            height: 180.0,
            decoration: BoxDecoration(
              color: Color.fromRGBO(62, 66, 107, 0.7),
            ),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: color,
                  radius: 35.0,
                  child: Icon(icono,color: Colors.white,size:30.0 ,),
                ),
                Text(texto,style: TextStyle(color: color),)
              ],
            ),
          ),

        ),
      ),
    );

  }
}