import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  
  
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();

  ProductoModel productoModel = new ProductoModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual, color: Colors.white,), 
            
            onPressed: null
         ),
         IconButton(
            icon: Icon(Icons.camera_alt, color: Colors.white,), 
            onPressed: null
         ),
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            //TODO ref form-submit
            key: formKey,
            child: Column(
              children: <Widget>[
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

  void _submit(){

    print('submit');
    //valida y retorna un bool
    if( !formKey.currentState.validate() ) return;

    //TODO FormFieldsOnsave
    formKey.currentState.save();

    print('todo ok ');
    print(productoModel.titulo);
    print(productoModel.valor);
    print(productoModel.disponible);
    
  }

  Widget _crearBoton(BuildContext context){
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: ()=> _submit(), 
      icon: Icon(Icons.save), 
      label: Text('Guardar')
    );
  }
}