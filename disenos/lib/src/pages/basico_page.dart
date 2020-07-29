import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    

    return Scaffold(

      // Column( Aqui la columna revienta no tiene un scroll
      //* ListView si nos da el scroll pero queda una barrita arriba pero para mi esta bien
      // 
    //   body: Column(
    //     children: <Widget>[
    //       _crearImagen(),
    //       _crearTitulo(context),
    //       _crearAcciones(),
    //       _crearTexto(),
    //       _crearTexto(),
    //       _crearTexto()

    //     ],
    //   )
    // );
      body: SingleChildScrollView(
        child:  Column(
          children: <Widget>[
            _crearImagen(),
            _crearTitulo(context),
            _crearAcciones(),
            _crearTexto(),
            _crearTexto(),
            _crearTexto()

          ],
        ),
      ),
    );
  }

  Widget _crearImagen() {
    return Container(
      //Al poner el Container y el width se soluciono el tema de que al poner la pantalla horitzontal no se expandia la imagen 
      width: double.infinity,
      child: Image(
              image: NetworkImage('https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&w=1000&q=80'),
              fit: BoxFit.cover
            ),
    );
  }




  Widget _crearTitulo(BuildContext context) {

    //estaba en Container ahora pasamos to -> SafeArea
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 20.0),
        child: Row(
          children: <Widget>[

            Expanded(
              child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Lago con un puente',style: Theme.of(context).textTheme.headline5, ),
                  SizedBox(height: 7.0),
                  Text('Un lago que se encuentra en alemania',style: Theme.of(context).textTheme.subtitle1)
                ],
              ),
            ),

            Icon(Icons.star, color: Colors.red, size: 30.0,),
            Text('41', style: Theme.of(context).textTheme.bodyText2,)

          ],
        ),
      ),
    );
    

  }


  Widget _crearAcciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[


       _accion(Icons.call,'CALL'),
       _accion(Icons.near_me,'ROUTE'),
       _accion(Icons.share,'SHARE'),

      ],
    );
  }


  Widget _accion( IconData icon, String texto ){
    return Column(
        children: <Widget>[
          Icon(icon, color: Colors.blue, size: 30.0,),
          SizedBox(height: 5.0,),
          Text(texto,style: TextStyle(fontSize: 15.0, color: Colors.blue))
        ],
      );
    }


  Widget _crearTexto(){
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Text(
         'Aute elit laborum occaecat dolor. Duis in amet est do excepteur enim reprehenderit et. Aliqua aute sit dolore consectetur dolor eu non. Pariatur id laborum excepteur irure id id culpa anim ex do enim exercitation nulla.',
         textAlign: TextAlign.justify,
        )
      ),
    );
  }
}