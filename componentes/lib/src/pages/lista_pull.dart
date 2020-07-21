import 'dart:async';

import 'package:flutter/material.dart';

class ListaPull extends StatefulWidget {
  ListaPull({Key key}) : super(key: key);

  @override
  _ListaPullState createState() => _ListaPullState();
}

class _ListaPullState extends State<ListaPull> {

  List<int> _listanumeros = new List();
  int _ultimoItem = 10;
  bool _isLoading = false;

  // este scroll  llamara para cargar otros 10

  ScrollController _scrollController = new ScrollController();
  



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // quiere cargar la lista de numeros antes 

    _agregar10();

    //Agregamos un listener al scrollcontroller

    _scrollController.addListener(() {
      
      //eseto se va a disparar cada ves que se mueva el scroll


      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        // hasta aca todo bien
        // _agregar10();

        //haremos que demore 2 seundos 
        fetchData();
      }
    });
  }

  //tenemos que desechar los scroll controller
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Listas'),
       ),

       body: Stack(
         children: <Widget>[
            _crearLista(),
            _crearLoading(),
         ],
       )
       
    );
  }

  Widget _crearLista(){

    return RefreshIndicator(

      onRefresh: obtenerPagina1,

      child: ListView.builder(
        //Aca enlazamos el scrollController
        controller: _scrollController,
        itemCount: _listanumeros.length,
        itemBuilder: (BuildContext context, int index) {
          final imagen = _listanumeros[index];
          return FadeInImage(
            placeholder: AssetImage('assets/loading.gif'), 
            image: NetworkImage('https://picsum.photos/500/300/?image=$imagen'),
          );
        }
      ),
    );

  }

  void _agregar10() {
    print('agregar10');
    print(_listanumeros);
    print(_ultimoItem);
    for (var i = 0; i < 10; i++) {
      _ultimoItem++;
      _listanumeros.add(_ultimoItem);
    }

    setState(() {
      
    });

  }

  Future fetchData() {
    //simulamos un delay 2 segundos antes de llamar a los otros 10
    _isLoading = true;
    setState(() {}); 
    final duration = new Duration(seconds: 2);
    // cuando pase 2 segundos llama a respuestaHTTP
    new Timer(duration,respuestaHTTP );


  }

  void respuestaHTTP() {
      _isLoading = false;

      //Mover el Scroll
      _scrollController.animateTo(
        _scrollController.position.pixels + 100, 
        duration: Duration(milliseconds: 250), 
        curve: Curves.fastOutSlowIn,
        
      );

      _agregar10();
  }

  Widget _crearLoading() {

    if(_isLoading){
      return 
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            )
          );
        
      
    }else{
      return Container();
    }

    //El loading esta feo aparece arriba izquierda

    // if(_isLoading){
    //   return CircularProgressIndicator();
    // }else{
    //   return Container();
    // }


  }

  Future<Null> obtenerPagina1() async {
    final duration = new Duration(seconds: 6);


      _listanumeros.clear();
      _ultimoItem++;
      _agregar10();
    return Future.delayed(duration);
  }
}