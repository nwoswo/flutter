import 'package:flutter/material.dart';

import 'package:formvalidation/src/bloc/login_bloc.dart';
import 'package:formvalidation/src/bloc/productos_bloc.dart';
export 'package:formvalidation/src/bloc/login_bloc.dart';


//TODO InheritedWidget
class ProviderIngered extends InheritedWidget {

  final loginBloc       = LoginBloc();
  final _productosBlock = ProductosBlock();

  //TODO Singleton Provider

  static ProviderIngered _instancia;
  factory ProviderIngered({Key key,Widget child}) {
    if(_instancia == null){
      _instancia = new ProviderIngered._internal(key: key, child: child);
    }
    return _instancia;
  }

  ProviderIngered._internal({Key key,Widget child}) : super(key: key,child: child);


  @override
  bool updateShouldNotify(InheritedWidget oldWidget)  => true;

  static LoginBloc of ( BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderIngered>().loginBloc;
  }

  static ProductosBlock ofprodBlock ( BuildContext context) {
    //busca en el arbol provider 
    return context.dependOnInheritedWidgetOfExactType<ProviderIngered>()._productosBlock;
  }

}



// import 'package:flutter/material.dart';

// import 'package:formvalidation/src/bloc/login_bloc.dart';
// export 'package:formvalidation/src/bloc/login_bloc.dart';


// //TODO InheritedWidget
// class ProviderIngered extends InheritedWidget {

//   //TODO Singleton Provider

//   static ProviderIngered _instancia;
//   factory ProviderIngered({Key key,Widget child}) {
//     if(_instancia == null){
//       _instancia = new ProviderIngered._internal(key: key, child: child);
//     }
//     return _instancia;
//   }

//   ProviderIngered._internal({Key key,Widget child}) : super(key: key,child: child);



//   final loginBloc = LoginBloc();

//   // Provider({Key key,Widget child}) : super(key: key,child: child);

//   @override
//   bool updateShouldNotify(InheritedWidget oldWidget)  => true;

//   static LoginBloc of ( BuildContext context) {
//       return context.dependOnInheritedWidgetOfExactType<ProviderIngered>().loginBloc;
//   }

// }