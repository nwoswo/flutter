import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Pelicula> peliculas;


  CardSwiper( {@required this.peliculas} );


  @override
  Widget build(BuildContext context) {

    //cambiar las dimenciones de la tarjeta dependiendo del tama;o del dispositivo
    //MEdia cuqery, da informacion del ancho y alto del dispositivo

    final _screenSize = MediaQuery.of(context).size;
    
    
    return  Container(
      margin: EdgeInsets.only(top: 5.0),
      // width: double.infinity,
      // height: _screenSize.height * 0.55,
      // color: Colors.red,
      child: Center(
    
        child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.65,
           itemHeight: _screenSize.height * 0.55,

          itemBuilder: (BuildContext context,int index){
            // print(peliculas[index].getPosterImge());

            //Id Unico
            peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';

            return Hero(
              tag: peliculas[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: (){
                     Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]);
                  },
                  child: FadeInImage(
                  placeholder: AssetImage('assets/loading.gif'), 
                  image: NetworkImage(peliculas[index].getPosterImge()),
                  fit: BoxFit.cover,
                      
                  ),
                ),
                // child: Image.network("https://via.placeholder.com/350x150",fit: BoxFit.fill,),
              ),
            );
          },
          itemCount: peliculas.length,
          // pagination: new SwiperPagination(),
          // control: new SwiperControl(),
          
          
        ),

      )  
    ); 

  }
}