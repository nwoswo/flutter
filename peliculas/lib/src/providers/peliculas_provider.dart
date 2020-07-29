

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {

  String _apiKey = 'cb402dd7e48a62d4a0a869021e1e2561';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularespage = 0;
  bool _cargando = false;

  //creamos el Stream
  // hasta aca tenemos la tuberia

  List<Pelicula> _populares = new List();
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;
  void disposeStreams() {
    _popularesStreamController?.close();
  }


  Future <List<Pelicula>> _procesarRespuesta(Uri url) async {

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList( decodedData['results'] );
    return peliculas.items;

  }

  Future<List<Pelicula>> getEncines()  async {

    final url  = Uri.https(_url, '3/movie/now_playing', {
      'api_key'   : _apiKey,
      'language'  : _language
    } );
    // final resp = await http.get(url);
    // //decode - > String to Map 
    // final decodedData = json.decode(resp.body);
    // // Map to Object 
    // final peliculas = new Peliculas.fromJsonList( decodedData['results'] );
    // return peliculas.items;
    // // return [];

    return await _procesarRespuesta(url);

  }


  Future<List<Pelicula>> getPopulares()  async {
      if(_cargando) return [];

      _cargando = true;
      _popularespage++;

      final url  = Uri.https(_url, '3/movie/popular', {
        'api_key'   : _apiKey,
        'language'  : _language,
        'page'  : _popularespage.toString()
      } );

    final resp = await  _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;


    // return await _procesarRespuesta(url);

  }

  Future<List<Pelicula>> buscarPelicula(String query)  async {

    final url  = Uri.https(_url, '3/search/movie', {
      'api_key'   : _apiKey,
      'language'  : _language,
      'query'     : query
    } );

    return await _procesarRespuesta(url);

  }
}