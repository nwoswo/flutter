import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/productos_bloc.dart';
import 'package:formvalidation/src/bloc/provider_inhered.dart';

import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';


class HomePage extends StatelessWidget {
  


  @override
  Widget build(BuildContext context) {

    final productosBloc = ProviderIngered.ofprodBlock(context);
    productosBloc.cargarProductos();
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: _crearListado(productosBloc),   
      floatingActionButton: _crearBoton(context),
      
    );
  }

  Widget _crearListado(ProductosBlock productosBlock){

  return StreamBuilder(
    stream: productosBlock.getproductosStream ,
    builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
      if( snapshot.hasData ){
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              return _crearItem(context, snapshot.data[i], snapshot.data, i,productosBlock);
            },
          );

        }else{
          return Center( child: CircularProgressIndicator(), );
        }
    },
  );


  }

  Widget _crearItem(BuildContext context, ProductoModel producto, List<ProductoModel> prod, int position,ProductosBlock productosBlock){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red
      ),
      onDismissed: (direccion) {
        // borrar producto

        productosBlock.borrarProducto(producto.id);

        // productosProvider.borarProducto(producto.id)
        //   .then((value) => setState(() {
        //     prod.removeAt(position);
        //   }));
      },
      child: Card(
        child: Column(
          children: <Widget>[

            (producto.fotoUrl == null) 
              ? Image(image: AssetImage('assets/image_default.png')) 
              : FadeInImage(
                  placeholder:  AssetImage('assets/loading.gif'), 
                  image: NetworkImage(producto.fotoUrl),
                  height: 300.0,
                  width: double.infinity,
                ),
            ListTile(
              title: Text('${producto.titulo} - ${producto.valor} '),
              subtitle: Text('${producto.id}'),
              onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto)
              // onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto).then((value) {    setState(() {          });  }),
            ),
          ],
        ),
      )
    );

    

  }

  _crearBoton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => Navigator.pushNamed(context, 'producto')
      // onPressed: () => Navigator.pushNamed(context, 'producto').then((value) {  setState(() {      });}),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:formvalidation/src/bloc/provider_inhered.dart';
// import 'package:formvalidation/src/models/producto_model.dart';
// import 'package:formvalidation/src/providers/productos_provider.dart';


// class HomePage extends StatefulWidget {
  
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final productosProvider = new ProductosProvider();

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home')
//       ),
//       body: _crearListado(),   
//       floatingActionButton: _crearBoton(context),
      
//     );
//   }

//   Widget _crearListado(){

//   return FutureBuilder(
//       future: productosProvider.cargarProductos(),
//       builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {

//         if( snapshot.hasData ){
//           return ListView.builder(
//             itemCount: snapshot.data.length,
//             itemBuilder: (context, i) {
//               return _crearItem(context, snapshot.data[i], snapshot.data, i);
//             },
//           );

//         }else{
//           return Center( child: CircularProgressIndicator(), );
//         }

//       },
//     );

//   }

//   Widget _crearItem(BuildContext context, ProductoModel producto, List<ProductoModel> prod, int position){
//     return Dismissible(
//       key: UniqueKey(),
//       background: Container(
//         color: Colors.red
//       ),
//       onDismissed: (direccion) {
//         // borrar producto
//         productosProvider.borarProducto(producto.id)
//           .then((value) => setState(() {
//             prod.removeAt(position);
//           }));
//       },
//       child: Card(
//         child: Column(
//           children: <Widget>[

//             (producto.fotoUrl == null) 
//               ? Image(image: AssetImage('assets/image_default.png')) 
//               : FadeInImage(
//                   placeholder:  AssetImage('assets/loading.gif'), 
//                   image: NetworkImage(producto.fotoUrl),
//                   height: 300.0,
//                   width: double.infinity,
//                 ),
//             ListTile(
//               title: Text('${producto.titulo} - ${producto.valor} '),
//               subtitle: Text('${producto.id}'),
//               onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto).then((value) {    setState(() {          });  }),
//             ),
//           ],
//         ),
//       )
//     );

    

//   }

//   _crearBoton(BuildContext context){
//     return FloatingActionButton(
//       child: Icon(Icons.add),
//       backgroundColor: Theme.of(context).primaryColor,
//       onPressed: () => Navigator.pushNamed(context, 'producto').then((value) {  setState(() {      });}),
//     );
//   }
// }