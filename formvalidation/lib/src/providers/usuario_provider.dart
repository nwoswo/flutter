import 'dart:convert';

import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {

  final String _firebaseToken = 'AIzaSyBYbMA-PZl6XhurZu_8AIOAzYY1Ki5wHu4';
  //TODO shared_preferences 1.1
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email,String password) async {

    final authData = {
      'email'             : email,
      'password'          : password  ,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode(authData)
    );

    final Map<String , dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    _prefs.token = decodedResp['idToken'];

    if(decodedResp.containsKey('idToken')) {
      //salvar el token en el storage
      return { 'ok'    : true, 'token' : decodedResp['idToken'] };
    }else {
      return { 'ok'    : false, 'message' : decodedResp['error']['message'] };

    }
    


  }

  Future<Map<String, dynamic>> nuevoUsuario(String email,String password) async {

    print('nuevoUsuario');

    final authData = {
      'email'             : email,
      'password'          : password  ,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    final Map<String , dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);
    _prefs.token = decodedResp['idToken'];

    if(decodedResp.containsKey('idToken')) {
      //salvar el token en el storage
      return { 'ok'    : true, 'token' : decodedResp['idToken'] };
    }else {
      return { 'ok'    : false, 'message' : decodedResp['error']['message'] };

    }

  }


}