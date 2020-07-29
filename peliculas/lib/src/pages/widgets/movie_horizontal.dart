

import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Pelicula> peliculas;

  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.27
  );

  @override
  Widget build(BuildContext context) {



    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {

      // 
      if( _pageController.position.pixels >= _pageController.position.maxScrollExtent ){
        print('Cargar siguientes peliculas');
        siguientePagina();
      }
    });

    return Container(
      width: double.infinity,
      height: _screenSize.height * 0.25,
      // color: Colors.blue,
      // child: PageView(
      //   controller: _pageController,
      //   // controller: PageController(
      //   //   initialPage: 1,
      //   //   viewportFraction: 0.27
      //   // ),
      //   pageSnapping: false,
      //   children: _tarjetas(context),
      // ),

       child: PageView.builder(
        controller: _pageController,
        pageSnapping: false,
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, i ) {
          return _tarjeta(context, peliculas[i] );
        },
      ),  

    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula ) {
   final _screenSize = MediaQuery.of(context).size;
   pelicula.uniqueId = '${pelicula.id}-poster';
   final tarjeta = Container(
      child: Column(
        children: <Widget>[

          Hero(
            tag: pelicula.uniqueId, //identifica esta tarjeta origin destino 
             // Aca ponemos el Hero 
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/loading.gif'), 
                image: NetworkImage(pelicula.getPosterImge()),
                fit: BoxFit.cover,
                // height:  160.0,
                height: _screenSize.height * 0.22,
              ),
            ),
          ),
          SizedBox(),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption
            )
        ],
      ),
    );
    
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
      child: tarjeta,
    );

  }

//  List<Widget> _tarjetas(BuildContext context) {

//    final _screenSize = MediaQuery.of(context).size;
//    return peliculas.map((pelicula) => 
//     Container(

//       child: Column(
//         children: <Widget>[
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20.0),
//             child: FadeInImage(
//               placeholder: AssetImage('assets/loading.gif'), 
//               image: NetworkImage(pelicula.getPosterImge()),
//               fit: BoxFit.cover,
//               // height:  160.0,
//               height: _screenSize.height * 0.22,
//             ),
//           ),
//           SizedBox(),
//           Text(
//             pelicula.title,
//             overflow: TextOverflow.ellipsis,
//             style: Theme.of(context).textTheme.caption
//             )
//         ],
//       ),
//     )
//    ).toList();

//  }
}