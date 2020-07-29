import 'package:shared_preferences/shared_preferences.dart';

class Preferenciasusuario {

  

  //TODO Singleton-Preferenciasusuario

  static final Preferenciasusuario _instancia = new Preferenciasusuario._internal();

  Preferenciasusuario._internal();

  factory Preferenciasusuario() {
    return _instancia;
  }

    //TODO guardar Settins
  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get genero {
    return _prefs.getInt('genero')?? 1;
  }

  set genero(int value){
    this._prefs.setInt('genero', value);
  }

  //get y et del _colorSecundario

  get colorSecundario {
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario(bool value) {
    _prefs.setBool('colorSecundario', value);
  }

  get nombreUsuario {
    return _prefs.getString('nombreusuario') ?? '';
  }

  set nombreUsuario(String value) {
    _prefs.setString('nombreusuario', value);
  }

   get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'home';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }



  //Ninguna de estas preferencias se usa
  // bool    _colorSecundario;
  // int     _genero;
  // String  _nombre;



}