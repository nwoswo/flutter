import 'package:flutter/material.dart';
import 'package:newprovider/src/provider/news_provider.dart';
import 'package:newprovider/src/views/tab1_page.dart';
import 'package:newprovider/src/views/tab2_page.dart';
import 'package:provider/provider.dart';


class Tabspage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    //TODO Provider ChangeNotifier 1.2
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(), //forma para crear la instancia de la clase 
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    //buscamos naegacionModel tendremos una instancia como si fuera un singleton
    //TODO Provider ChangeNotifier 1.3
    final navegacionModel = Provider.of<_NavegacionModel>(context); //


    return BottomNavigationBar(
      
      //TODO Provider ChangeNotifier 1.1
      onTap: (i) => navegacionModel.paginaActual = i,//cambiando
      currentIndex: navegacionModel.getpaginaActual, //escuchando
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), title: Text('Para ti')),
        BottomNavigationBarItem(icon: Icon(Icons.public), title: Text('Encabezados')),
      ]
    );
  }
}



class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //TODO Provider ChangeNotifier 1.4
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    

    return PageView(
      controller: navegacionModel.getpageController,
      physics: NeverScrollableScrollPhysics(), // no puede scroll de pagina
      // physics: BouncingScrollPhysics(),
      children: <Widget>[
        
        Tab1Page(),

        Tab2page(),

      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {

  // no solo maneja primitivos, tambien Page Controller

  int _paginaActual = 0;
  PageController _pageController = new PageController();



  int get getpaginaActual => this._paginaActual;
  PageController get getpageController => this._pageController;


  //TODO Provider ChangeNotifier 1.0
  //?? procedimiento que redibuje los widgets ChangeNotifier
  //notifico a todos los widgets que esten pendientes de ese valor
  set paginaActual(int valor) {
    this._paginaActual = valor;
    
    _pageController.animateToPage(
      valor, 
      duration: Duration(milliseconds: 250), 
      curve: Curves.easeOut
    );
    notifyListeners();
  }

  

}