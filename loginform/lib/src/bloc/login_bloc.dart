import 'dart:async';

import 'package:formvalidation/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';


class LoginBloc with Validators  {

  //TODO Block login
  //cada ves que tecleamos algo en el input del email pasara por este Stream
  // final _emailController = StreamController<String>.broadcast();
  // final _passwordController = StreamController<String>.broadcast();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //TODO Convine Stream 1.2
  //obtener el ultimo valor a los Streams

  String get getemail => _emailController.value;
  String get getpassword => _passwordController.value;

//Recuperar los datos del Stream


//TODO StreamTransformer 1.1
Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
Stream<String> get emailStream => _emailController.stream.transform(validarEmail);

//TODO Convine Stream
//los StreamController  no son conocidos en RxDart

Stream<bool> get formValidStream => 
  CombineLatestStream.combine2(_emailController,_passwordController, (e,p) => true);


//Insertar valores al Stream
Function(String) get changeEmail => _emailController.sink.add;
Function(String) get changePassword => _passwordController.sink.add;


dispose(){
  _emailController?.close();
  _passwordController?.close();
}

}