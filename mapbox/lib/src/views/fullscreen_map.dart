import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http; 

class FullScreenMap extends StatefulWidget {

  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;
  final  center =  LatLng(-15.493386,-70.135166);

  String selectedStyle = 'mapbox://styles/nwoswo/ckd4g727j10i41hny6qov33cc';
  final standarStyle = 'mapbox://styles/nwoswo/ckd3661713gcn1hqxs62jqs7y';
  final streetStyle = 'mapbox://styles/nwoswo/ckd4g727j10i41hny6qov33cc';

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl("networkImage", "https://via.placeholder.com/50");
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, String url) async {
    var response = await http.get(url);
    return mapController.addImage(name, response.bodyBytes);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: botonesFlotantes(),
    );
  }



  Column botonesFlotantes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[

         //Simbolos
        FloatingActionButton(
          child: Icon(Icons.location_on),
          onPressed: (){
            // mapController.animateCamera(CameraUpdate.tiltTo(40.0) );
            mapController.addSymbol(SymbolOptions( 
              // iconSize: 3,
              iconImage: 'assetImage',
              // iconColor: Colors.blue.toString(),
              geometry: center,
              textField: 'Punto creado Aqui',
              textOffset: Offset(0,2)

             ) );
          }
        ),

        SizedBox(height: 5,),

        //ZoomIn
        FloatingActionButton(
          child: Icon(Icons.zoom_in),
          onPressed: (){
            // mapController.animateCamera(CameraUpdate.tiltTo(40.0) );
            mapController.animateCamera(CameraUpdate.zoomIn() );
          }
        ),

        SizedBox(height: 5,),

         //ZoomOut
        FloatingActionButton(
          child: Icon(Icons.zoom_out),
          onPressed: (){
            // mapController.animateCamera(CameraUpdate.tiltTo(40.0) );
            mapController.animateCamera(CameraUpdate.zoomOut() );
          }
        ),

        SizedBox(height: 5,),


        //boton cambiar stilo
        FloatingActionButton(
          child: Icon(Icons.add_to_home_screen),
          onPressed: () {
            if( selectedStyle== streetStyle ){
              selectedStyle = standarStyle;
            }else{
              selectedStyle=streetStyle;
            }

            setState(() {});

          }
        )
      ],
    );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
      styleString: selectedStyle,
      onMapCreated: _onMapCreated,
      initialCameraPosition:
      CameraPosition(
        target: center,
        zoom: 14  
      ),
    );
  }
}