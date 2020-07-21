import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  
  final List<dynamic> peliculas;


  CardSwiper( {@required this.peliculas} );


  @override
  Widget build(BuildContext context) {

    //cambiar las dimenciones de la tarjeta dependiendo del tama;o del dispositivo
    //MEdia cuqery, da informacion del ancho y alto del dispositivo

    final _screenSize = MediaQuery.of(context).size;
    

    return  Container(
      margin: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: _screenSize.height * 0.45,
      child: Center(
    
        child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.45,

          itemBuilder: (BuildContext context,int index){
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network("https://via.placeholder.com/350x150",fit: BoxFit.fill,),
            );
          },
          itemCount: 3,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
          
          
        ),

    )  
    ); 

  }
}