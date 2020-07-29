import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/actores_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  


  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      
        body: CustomScrollView(
          slivers: <Widget>[
            _crearAppbar( pelicula ),
            SliverList(
              delegate: SliverChildListDelegate(
              
               [
                 SizedBox(height: 10.0,),
                 _posterTitulo(context,pelicula),
                 _descripcion(pelicula),
                 _crearActores(pelicula.id.toString()),

               ]
              )
            )
          ],
        ),
      );
  }

  
  Widget _crearActores(String peliId) {

    final actoresProvider = new ActoresProvider();

    return FutureBuilder(
      future: actoresProvider.getActores(peliId),
      // initialData: []],
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        
        if(snapshot.hasData){
          return _crearActoresPageview(snapshot.data);
        }else{
          return Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );

  }

  Widget _crearActoresPageview(List<Actor> actores) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: actores.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemBuilder: (context,i) {
          return _actorTarjeta( actores[i]);
        }
      ),
    );
  }

  Widget _actorTarjeta(Actor actor){
    return Container(
      child: Column(
        children: <Widget>[

          ClipRRect(
            borderRadius:BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getFoto()),
              placeholder: AssetImage('assets/loading.gif'), 
              fit: BoxFit.cover,
              height: 150.0,
            ),
          ),

          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,  vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );

  }

  Widget _posterTitulo(BuildContext context ,Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20.0 ),
      child: Row(
        children: <Widget>[

          //ClipRect Image
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImge()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          //Flexible
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(pelicula.title, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis,),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon( Icons.star_border ),
                    Text(pelicula.voteAverage.toString())
                  ],
                )
              ],
            )
          )

          
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0 ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage( pelicula.getBackgroundImg() ),
          fit:  BoxFit.cover,
        ),
      ),
    );

  }




  

  
}