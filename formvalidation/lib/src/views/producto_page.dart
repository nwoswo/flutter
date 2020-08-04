

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/productos_bloc.dart';
import 'package:formvalidation/src/bloc/provider_inhered.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  
  
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey =  GlobalKey<ScaffoldState>();
  ProductosBlock productosBlock;
  ProductoModel productoModel = new ProductoModel();
  bool _guardando = false;
  
  final _picker = ImagePicker(); //from image_picker
  File  foto;

  @override
  Widget build(BuildContext context) {
  productosBlock = ProviderIngered.ofprodBlock(context);
    //editar
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if(prodData != null) {
      productoModel = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: _appBar(),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            //TODO ref form-submit
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                SizedBox(height: 10.0,),
                _crearBoton(context),
              ],
            ),
          ),
        ),
      ),

    );
  }

  Widget _appBar(){
    return AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual, color: Colors.white,), 
            
            onPressed: _seleccionarFoto,
         ),
         IconButton(
            icon: Icon(Icons.camera_alt, color: Colors.white,), 
            onPressed: _tomarFoto
         ),
        ],
      );
  }

  _mostrarFoto(){

    if(productoModel.fotoUrl !=null){
      // tengo que hacer
      return FadeInImage(
        placeholder:  AssetImage('assets/loading.gif'), 
        image: NetworkImage(productoModel.fotoUrl),
        height: 300.0,
        width: double.infinity,
      );
    }else{

      return (foto == null) ? Image(
        image: AssetImage('assets/image_default.png'),
        height: 300.0,
        fit: BoxFit.cover,
      ) : Image.file(
        foto,
        height: 300,
        fit: BoxFit.cover,
      );
      
      // return Image(
      //   image: AssetImage( foto?.path ?? 'assets/image_default.png'),
      //   height: 300.0,
      //   fit: BoxFit.cover,
      // );

    }

  }

  _seleccionarFoto() async {
    await  _procesarImagen(ImageSource.gallery);
      if(foto != null){
        productoModel.fotoUrl = null;
    } 

    setState(() {});
    
  }
  _tomarFoto() async {
    await _procesarImagen(ImageSource.camera);
    if(foto != null){
      productoModel.fotoUrl = null;
    } 

    setState(() {});

  }

  _procesarImagen(ImageSource tipo) async {
    
    final pickedFile = await _picker.getImage(
      source: tipo
    );
    foto = File(pickedFile.path);

  }



  Widget _crearNombre(){
    return TextFormField(
      initialValue: productoModel.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (value) => productoModel.titulo = value,
      validator: (value) {
        if( value.length < 3 ){
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      }
    );
  }

  Widget _crearPrecio(){
    return TextFormField(
      // keyboardType: TextInputType.numberWithOptions(),
      initialValue: productoModel.valor.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      //onSaved solo se ejecuta cuando el formulario es valido 
      onSaved: (value) => productoModel.valor = double.parse(value),
      validator: (value) {
        if( utils.insNumeric(value) ){
          return null;
        }else{
          return 'Solo Numeros';
        }
      },
    );
  }

  Widget _crearDisponible(){
    return SwitchListTile(
      activeColor: Theme.of(context).primaryColor,
      title: Text('Disponible'),
      value: productoModel.disponible, 
      onChanged: (value) => setState( () {
        productoModel.disponible = value;
      } ),
    );
  }

  void _submit() async{

    print('submit');
    //valida y retorna un bool
    if( !formKey.currentState.validate() ) return;

    //TODO FormFieldsOnsave
    formKey.currentState.save();
    
    setState(() { _guardando = true; });
    if(foto !=null){
      // productoModel.fotoUrl = await productosProvider.subirImagen(foto);
      productoModel.fotoUrl = await productosBlock.subirFoto(foto);
    }

    if(productoModel.id == null){
      // productosProvider.crearProducto(productoModel);
      productosBlock.agregarProducto(productoModel);
    }else {
      // productosProvider.editarProducto(productoModel);
      productosBlock.editarProducto(productoModel);
    }

    mostrarSnackbar('Registro Guardado');
    
    Navigator.pop(context);
    
  }

  Widget _crearBoton(BuildContext context){
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      
      icon: Icon(Icons.save), 
      label: Text('Guardar'),
      //habilitar desabilitar
      onPressed: (_guardando) ? null: _submit
    );
  }
  
  void mostrarSnackbar(String mensaje){
    final snackbar  = SnackBar(
      content: Text('mensaje'),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
    // setState(() { _guardando = false; });
  }
}














// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:formvalidation/src/models/producto_model.dart';
// import 'package:formvalidation/src/providers/productos_provider.dart';
// import 'package:formvalidation/src/utils/utils.dart' as utils;
// import 'package:image_picker/image_picker.dart';

// class ProductoPage extends StatefulWidget {
  
  
//   @override
//   _ProductoPageState createState() => _ProductoPageState();
// }

// class _ProductoPageState extends State<ProductoPage> {
//   final formKey = GlobalKey<FormState>();
//   final scaffoldKey =  GlobalKey<ScaffoldState>();

//   ProductoModel productoModel = new ProductoModel();
//   bool _guardando = false;
//   final productosProvider = new ProductosProvider();
//   final _picker = ImagePicker(); //from image_picker
//   File  foto;

//   @override
//   Widget build(BuildContext context) {

//     //editar
//     final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
//     if(prodData != null) {
//       productoModel = prodData;
//     }

//     return Scaffold(
//       key: scaffoldKey,
//       appBar: _appBar(),

//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(15.0),
//           child: Form(
//             //TODO ref form-submit
//             key: formKey,
//             child: Column(
//               children: <Widget>[
//                 _mostrarFoto(),
//                 _crearNombre(),
//                 _crearPrecio(),
//                 _crearDisponible(),
//                 SizedBox(height: 10.0,),
//                 _crearBoton(context),
//               ],
//             ),
//           ),
//         ),
//       ),

//     );
//   }

//   Widget _appBar(){
//     return AppBar(
//         title: Text('Producto'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.photo_size_select_actual, color: Colors.white,), 
            
//             onPressed: _seleccionarFoto,
//          ),
//          IconButton(
//             icon: Icon(Icons.camera_alt, color: Colors.white,), 
//             onPressed: _tomarFoto
//          ),
//         ],
//       );
//   }

//   _mostrarFoto(){

//     if(productoModel.fotoUrl !=null){
//       // tengo que hacer
//       return FadeInImage(
//         placeholder:  AssetImage('assets/loading.gif'), 
//         image: NetworkImage(productoModel.fotoUrl),
//         height: 300.0,
//         width: double.infinity,
//       );
//     }else{

//       return (foto == null) ? Image(
//         image: AssetImage('assets/image_default.png'),
//         height: 300.0,
//         fit: BoxFit.cover,
//       ) : Image.file(
//         foto,
//         height: 300,
//         fit: BoxFit.cover,
//       );
      
//       // return Image(
//       //   image: AssetImage( foto?.path ?? 'assets/image_default.png'),
//       //   height: 300.0,
//       //   fit: BoxFit.cover,
//       // );

//     }

//   }

//   _seleccionarFoto() async {
//     await  _procesarImagen(ImageSource.gallery);
//       if(foto != null){
//         productoModel.fotoUrl = null;
//     } 

//     setState(() {});
    
//   }
//   _tomarFoto() async {
//     await _procesarImagen(ImageSource.camera);
//     if(foto != null){
//       productoModel.fotoUrl = null;
//     } 

//     setState(() {});

//   }

//   _procesarImagen(ImageSource tipo) async {
    
//     final pickedFile = await _picker.getImage(
//       source: tipo
//     );
//     foto = File(pickedFile.path);

//   }



//   Widget _crearNombre(){
//     return TextFormField(
//       initialValue: productoModel.titulo,
//       textCapitalization: TextCapitalization.sentences,
//       decoration: InputDecoration(
//         labelText: 'Producto'
//       ),
//       onSaved: (value) => productoModel.titulo = value,
//       validator: (value) {
//         if( value.length < 3 ){
//           return 'Ingrese el nombre del producto';
//         }else{
//           return null;
//         }
//       }
//     );
//   }

//   Widget _crearPrecio(){
//     return TextFormField(
//       // keyboardType: TextInputType.numberWithOptions(),
//       initialValue: productoModel.valor.toString(),
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         labelText: 'Precio'
//       ),
//       //onSaved solo se ejecuta cuando el formulario es valido 
//       onSaved: (value) => productoModel.valor = double.parse(value),
//       validator: (value) {
//         if( utils.insNumeric(value) ){
//           return null;
//         }else{
//           return 'Solo Numeros';
//         }
//       },
//     );
//   }

//   Widget _crearDisponible(){
//     return SwitchListTile(
//       activeColor: Theme.of(context).primaryColor,
//       title: Text('Disponible'),
//       value: productoModel.disponible, 
//       onChanged: (value) => setState( () {
//         productoModel.disponible = value;
//       } ),
//     );
//   }

//   void _submit() async{

//     print('submit');
//     //valida y retorna un bool
//     if( !formKey.currentState.validate() ) return;

//     //TODO FormFieldsOnsave
//     formKey.currentState.save();
    
//     setState(() { _guardando = true; });
//     if(foto !=null){
//       productoModel.fotoUrl = await productosProvider.subirImagen(foto);

//     }

//     if(productoModel.id == null){
//       productosProvider.crearProducto(productoModel);
//     }else {
//       productosProvider.editarProducto(productoModel);
//     }

//     mostrarSnackbar('Registro Guardado');
    
//     Navigator.pop(context);
    
//   }

//   Widget _crearBoton(BuildContext context){
//     return RaisedButton.icon(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0)
//       ),
//       color: Theme.of(context).primaryColor,
//       textColor: Colors.white,
      
//       icon: Icon(Icons.save), 
//       label: Text('Guardar'),
//       //habilitar desabilitar
//       onPressed: (_guardando) ? null: _submit
//     );
//   }
  
//   void mostrarSnackbar(String mensaje){
//     final snackbar  = SnackBar(
//       content: Text('mensaje'),
//       duration: Duration(milliseconds: 1500),
//     );

//     scaffoldKey.currentState.showSnackBar(snackbar);
//     // setState(() { _guardando = false; });
//   }
// }