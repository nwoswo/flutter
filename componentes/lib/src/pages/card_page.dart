import 'package:flutter/material.dart';

class Cardpage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        
        
        children: <Widget>[
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
      ],),
    );
  }

  Widget _cardTipo1() {

    return Card(
      elevation: 10.0,
      //border
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_album,color: Colors.blue),
            title: Text('Soy el titulo de esta tarjeta'),
            subtitle: Text('Eiusmod reprehenderit qui labore officia eiusmod labore. Aliqua pariatur id et culpa. Aliqua Lorem dolor adipisicing exercitation. Fugiat esse esse officia cupidatat consectetur excepteur est fugiat in pariatur.'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('Calendar'),
                onPressed: () {},
              ),

              FlatButton(
                child: Text('Ok'),
                onPressed: () {},
              ),

            ],
          )
        ],
      ),
    );

  }

  Widget _cardTipo2() {
    final card = Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
      //clip ayuda a que nada de lo que esta en la tarjeta se salga del card
      //clipBehaviur
      // clipBehavior: ,
      child: Column(
        children: <Widget>[

          FadeInImage(
            placeholder: AssetImage('assets/loading.gif'), 
            // image: NetworkImage('https://cdn.cnn.com/cnnnext/dam/assets/190517091026-07-unusual-landscapes-travel.jpg'),
            image: AssetImage('assets/imagen1.jpg'),
            height: 300.0,
            fit: BoxFit.cover,

          ),

          // Image(
          //   image: NetworkImage('https://cdn.cnn.com/cnnnext/dam/assets/190517091026-07-unusual-landscapes-travel.jpg')
          // ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('No tengo idea de que poner '),
          )
        ],
      ),
    );

    // return Container(
       
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(30.0),
    //       color: Colors.white,
    //       boxShadow: <BoxShadow> [
    //         BoxShadow(
    //           color: Colors.black26,
    //           blurRadius: 10.0,
    //           spreadRadius: 2.0,
    //           offset: Offset(2.0,10.0)
    //         )
    //       ]
    //     ),
    //      child: ClipRRect(
    //         borderRadius: BorderRadius.circular(30.0),
            
    //         child: card
    //        ),
    //   );

      return card;
  }
}