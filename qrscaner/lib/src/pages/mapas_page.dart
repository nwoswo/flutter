import 'package:flutter/material.dart';
import 'package:qrscaner/src/bloc/scan_bloc.dart';
import 'package:qrscaner/src/models/scan_model.dart';
// import 'package:qrscaner/src/providers/db_provider.dart';
import 'package:qrscaner/src/utils/scan_utils.dart' as scan_utils;

class MapasPage extends StatelessWidget {
  
    //TODO-BLOCK MapasPage
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

     //cuando regresamos mediante los botones de abajo 
     scansBloc.obtenerScans();

     return StreamBuilder<List<ScanModel>>( 

    // return FutureBuilder<List<ScanModel>>(
      //ahora usaremos patron Bloc
      // future: DBProvider.db.getTodosScans(),
      stream: scansBloc.scansStream,
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        
        if(!snapshot.hasData){
          return Center( child: CircularProgressIndicator(), );
        }

        final scans = snapshot.data;

        if(scans.length == 0){
          return Center(
            child: Text('No hay informacion'),
          );
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context,i) => Dismissible(   // pusimos esto para poder borrar como opcion
            key: UniqueKey(), //flutter nos da esto para saber que registro borrar
            background: Container( color: Colors.red,),
            // onDismissed: (direccion) => DBProvider.db.deleteScan(scans[i].id)  , //el metodo  para borrar porque atras es solo visual
            onDismissed: (direccion) => scansBloc.borrarScan(scans[i].id)  , //el metodo  para borrar porque atras es solo visual
            child: ListTile(
              leading: Icon (Icons.http, color: Theme.of(context).primaryColor ,),
              title: Text(scans[i].valor),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
              onTap: () => scan_utils.launchURL(context,scans[i]),
            ),
          )
        );
      },
    );
  }
}