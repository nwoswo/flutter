
import 'dart:async';

class Validators{

  static Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';


  //TODO StreamTransformer 1.0
  final validarPassword = StreamTransformer<String,String>.fromHandlers(
    handleData: (password,sink) {
      if(password.length >= 6 ){
        //deje fluir este password
        sink.add(password);
      }else {
        sink.addError('Mas de 6 caracteres porfavor');
      }
    }
  );

  final validarEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink) {
      RegExp regExp = new RegExp(pattern);

      if( regExp.hasMatch(email) ) {
        sink.add(email);
      }else{
        sink.addError('Email no es correcto');
      }
      
    }
  );


}