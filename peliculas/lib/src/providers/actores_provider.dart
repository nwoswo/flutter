

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';



class ActoresProvider {

  String _apiKey = 'cb402dd7e48a62d4a0a869021e1e2561';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';





  Future <List<Actor>> _procesarRespuesta(Uri url) async {

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final actores = new Actores.fromJsonList( decodedData['results'] );
    return actores.items;

  }

  Future<List<Actor>> getActores(String peliId) async {

    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key'   : _apiKey,
      'language'  : _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final actores = new Actores.fromJsonList(decodedData['cast']);

    return actores.items;


  }


}