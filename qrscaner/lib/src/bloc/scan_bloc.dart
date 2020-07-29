

import 'dart:async';

import 'package:qrscaner/src/providers/db_provider.dart';
import 'package:qrscaner/src/bloc/validator.dart';

class ScansBloc with Validators {

  //TODO Singleton-scan bloc


  //final scanBlock = new ScansBlocl


  static final ScansBloc _singleton = new ScansBloc._interntal();

  factory ScansBloc(){
    return _singleton;
  }

  
  ScansBloc._interntal(){
    //obtener los Scans de la base de datos
     obtenerScans();
  }

  //TODO Stream Controller
  // controllara el flujo de datos
  //broadcast para que todos se enteren
  //que informacion fluira 
  final _scansController = StreamController<List<ScanModel>>.broadcast();
  //Stream
  Stream<List<ScanModel>>  get scansStream => _scansController.stream.transform(validarGeo);
  Stream<List<ScanModel>>  get scansStreamHttp => _scansController.stream.transform(validarHttp);

  dispose(){
    _scansController?.close();
  }

  //SINK

  obtenerScans() async {
    _scansController.sink.add( await DBProvider.db.getTodosScans() );
  }


  agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }



  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }

}