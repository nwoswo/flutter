import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/pages/widgets/card_swiper.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
          centerTitle: false,
          title: Text('Peliculas en cines'),
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search), 
              onPressed: null
              )
          ],
        
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperTarjetas()
          ],
        ),
      ),
     
    );
  }

  Widget _swiperTarjetas() {

    return CardSwiper(peliculas: []);
  }

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
}