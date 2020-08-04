import 'dart:io';

import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'package:formvalidation/src/models/producto_model.dart';


class ProductosBlock {

  //streamController que diga cuando estan subiendo informacion 
  // informacion que va a fluir
  final _productosController = new BehaviorSubject<List<ProductoModel>>();
  
  // stream para listar 
  final _cargandoController = new BehaviorSubject<bool>();


  //referencia a los productos Provider
  //la idea es que salgan del block y no del provider
  final _productosProvider = new ProductosProvider();

  
  //necesito escuchar ambos streams -> reducir el codigo 
  Stream<List<ProductoModel>> get getproductosStream => _productosController.stream;
  Stream<bool> get getcargandoStream => _cargandoController.stream;

  void cargarProductos() async {
    final productos = await _productosProvider.cargarProductos();
    _productosController.sink.add(productos);
  }

  void agregarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosProvider.crearProducto(producto);
    _cargandoController.sink.add(false);
  }

  Future<String>  subirFoto(File foto) async {
    _cargandoController.sink.add(true);
    final fotoUrl = await _productosProvider.subirImagen(foto);
    _cargandoController.sink.add(false);

    return fotoUrl;
  }

  void editarProducto(ProductoModel producto) async {
    _cargandoController.sink.add(true);
    await _productosProvider.editarProducto(producto);
    _cargandoController.sink.add(false);
  }

  void borrarProducto(String id) async {
    
    await _productosProvider.borarProducto(id);
    
  }



  dispose() {
    _productosController?.close();
    _productosController?.close();
  }

}