import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrscaner/src/bloc/scan_bloc.dart';
import 'package:qrscaner/src/models/scan_model.dart';
import 'package:qrscaner/src/pages/direcciones_page.dart';
import 'package:qrscaner/src/pages/mapas_page.dart';
import 'package:qrscaner/src/utils/scan_utils.dart' as scan_utils;
// import 'package:qrscaner/src/providers/db_provider.dart';


class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //TODO-BLOCK HomePage
  final scansBloc = new ScansBloc();

  int currentIndex =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // body: Center(
      //   child: Text('Hola Home Page'),
      // ),
      appBar: _myAppBar(),
      body: _callpage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _myFloatingActionButton(context),

    );
  }

  Widget _myAppBar(){
    return AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever), 
            onPressed: () {
              scansBloc.borrarScanTodos();
            }
          )
        ],
      );
  }

  _scanQR(BuildContext context) async {

    // https://fernando-herrera.com
    // -12.067440,-77.043043
    
    
    dynamic  futureString;
   
    // try {
    //   futureString = await BarcodeScanner.scan();
    // } catch (e) {
    //   futureString = e.toString();
    // }

    // print('Future String: ${futureString.rawContent}');


    


    if(futureString!=null){
      final scan = ScanModel( valor: futureString.toString() );
      // DBProvider.db.nuevoScan(scan);
      //patron bloc
      scansBloc.agregarScan(scan);

     

      if( Platform.isIOS ){
        Future.delayed( Duration( milliseconds: 750 ), () {
           scan_utils.launchURL(context,scan);
        } );
      }else{
           scan_utils.launchURL(context,scan);
      }

     
    }

    //    //REAL 
    //   // dynamic  futureString = 'https://fernando-herrera.com';
    //  if(futureString!=null){
    //     final scan = ScanModel( valor: futureString.toString() );
    //     // DBProvider.db.nuevoScan(scan);
    //     //patron bloc
    //     scansBloc.agregarScan(scan);

    //     final scan2 = ScanModel( valor: 'geo:-15.493363,-70.135164' );
    //     scansBloc.agregarScan(scan2);

    //     if( Platform.isIOS ){
    //       Future.delayed( Duration( milliseconds: 750 ), () {
    //          scan_utils.launchURL(context,scan);
    //       } );
    //   }else{
    //          scan_utils.launchURL(context,scan);
    //  }

     
    }

    
  }

  Widget _myFloatingActionButton(BuildContext context){
    return  FloatingActionButton(
        child: Icon( Icons.filter_center_focus ),
        onPressed: () =>  _scanQR(context),

  
        //TODO-THEME backgroundColor
        backgroundColor: Theme.of(context).primaryColor,
      );
  }


 

  Widget _crearBottomNavigationBar(){
    return BottomNavigationBar(
      // que elemento esta activo
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex =  index;
        });
      },
      items: [

        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        ),

      ]
    );
  }


   Widget _callpage(int paginaActual){

    switch (paginaActual) {
      case 0 :  return MapasPage();
      case 1 :  return DireccionesPage();

        break;
      default: return MapasPage();
    }
  }

}