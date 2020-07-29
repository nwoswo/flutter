import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  // String seleccion = '';

  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Spiderman',
    'Aquaman'
  ];

  final peliculasRecientes = [
    'Spiderman',
    'Capitan America'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
      // Acciones de nuestro AppBar  
      //  Acciones -> Ejem icono para limpiar el texto
      return [
        IconButton(
          icon: Icon( Icons.clear), 
          onPressed: () {
            query = '';
          }
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono a la izquierda del Appbar 
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        },
      );
    }
  
    @override
    Widget buildResults(BuildContext context ) {
      // Crear los resultados que vamos a mostrar
      return Center(
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.blueAccent,
          child: Text(query),
        ),
      );
    }
  

    @override
    Widget buildSuggestions(BuildContext context) {
    // son las sugerencias que aparecen cuando la persona escribe

    if(query.isEmpty) return Container();

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        
        if(snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
            children:peliculas.map((e) {
             return ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage('assets/image_default.png'), 
                    image: NetworkImage(e.getPosterImge()),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(e.title),
                  subtitle: Text(e.originalTitle),
                  onTap: () {
                    close(context, null);
                    e.uniqueId = '';
                    Navigator.pushNamed(context, 'detalle', arguments: e);
                  },
                );
              }
            ).toList(),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }


      },
    );

  }


  //   @override
  //   Widget buildSuggestions(BuildContext context) {
  //   // son las sugerencias que aparecen cuando la persona escribe

  //   // a esta lista aplicamos el Filtro
  //   final listaSugerida = (query.isEmpty) 
  //                           ? peliculasRecientes
  //                           : peliculas.where(
  //                             (element) => element.toLowerCase().startsWith(query) ).toList();

  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context,i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: () {
  //           seleccion = listaSugerida[i];

  //           //construir los resultados

  //           showResults(context);
  //         },
  //       );
  //     }
  //   );
  // }

}