import 'package:flutter/material.dart';

import 'package:peliculas/src/pages/widgets/card_swiper.dart';
import 'package:peliculas/src/pages/widgets/movie_horizontal.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
  // Widget _swiperTarjetas() {

  //   return  Container(
  //     width: double.infinity,
  //     height: 300.0,
  //     child: Swiper(
  //         itemBuilder: (BuildContext context,int index){
  //           return Image.network("https://via.placeholder.com/350x150",fit: BoxFit.fill,);
  //         },
  //         itemCount: 3,
  //         pagination: new SwiperPagination(),
  //         control: new SwiperControl(),
  //         layout: SwiperLayout.TINDER,
  //         itemWidth: 250.0,
  //         itemHeight: 3400.0,
  //       ),
  //   );

  // }



class HomePage extends StatelessWidget {
  
final peliculasProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          
          centerTitle: false,
          title: Text('Peliculas en cines'),
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search), 
              onPressed: () {
                showSearch(
                  context: context, 
                  delegate: DataSearch(),
                  // query: 'Hola'
                );
              }
              )
          ],
        
      ),
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
     
    );
  }

  Widget  _footer(BuildContext context) {
  // final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      // height: _screenSize.height * 0.41,
      // color: Colors.red,
        child: Column(
          children: <Widget>[
          
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only( left: 10.0,top: 15.0 ),
                child: 
                    Text('Populares', style: Theme.of(context).textTheme.subtitle1   ),
              ),
            StreamBuilder(
              stream: peliculasProvider.popularesStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if( snapshot.hasData ){
                  return MovieHorizontal(
                      peliculas: snapshot.data,
                      siguientePagina: peliculasProvider.getPopulares,
                    );
                }else{
                  return Center(child: CircularProgressIndicator());
                }
                
              },
            ), 
          ],
        ),
    
    );

  }

  //////////////////////////////
  //  Footer con FutureFuilber

  // Widget  _footer(BuildContext context) {
  //   // final _screenSize = MediaQuery.of(context).size;
  //   return Container(
  //     width: double.infinity,
  //     // height: _screenSize.height * 0.41,
  //     // color: Colors.red,
  //       child: Column(        
  //         children: <Widget>[
          
  //           Container(
  //               alignment: Alignment.centerLeft,
  //               padding: EdgeInsets.only( left: 10.0,top: 15.0 ),
  //               child: 
  //                   Text('Populares', style: Theme.of(context).textTheme.subtitle1   ),
  //             ),
  //           FutureBuilder(
  //             future: peliculasProvider.getPopulares(),
  //             //en lugar de un init se pondra un loading
  //             // initialData: InitialData,
  //             builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
  //               if( snapshot.hasData ){
  //                 return MovieHorizontal(peliculas: snapshot.data);
  //               }else{
  //                 return Center(child: CircularProgressIndicator());
  //               }
                
  //             },
  //           ), 
  //         ],
  //       ),
    
  //   );

  // }


  Widget _swiperTarjetas() {
    //Ojo es un Future
    //tenemos que enviar este fugure a un builder  
    // peliculasProvider.getEncines();
    // antes no cargaba por que no pusimos el return 
    return FutureBuilder(
      future: peliculasProvider.getEncines(),
      // en lugar de un initial se pondra un loading
      // initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        //unicamente si hay data cuando tenemos data 
        print(snapshot.hasData);
        if(snapshot.hasData){
          print('true');
          return CardSwiper(
            peliculas: snapshot.data
          ) ;
        }else {
          return Container(
            height: 350.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
      },
    );

    // return CardSwiper(peliculas: []);
  }



}