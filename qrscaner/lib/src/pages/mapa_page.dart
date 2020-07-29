import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrscaner/src/models/scan_model.dart';
import 'package:latlong/latlong.dart';

class MapaPage extends StatelessWidget {
 
  final mapCtrl = new MapController();
  

  @override
  Widget build(BuildContext context) {

    final ScanModel scan =  ModalRoute.of(context).settings.arguments;
    final resolutions = <double>[32768, 16384, 8192, 4096, 2048, 1024, 512, 256, 128];
    final ymaxZoom = (resolutions.length - 1).toDouble();


    print('Max Zoom $ymaxZoom');
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location), 
            onPressed: () {
              mapCtrl.move(
                scan.getLatLng(), 15.0
              );
            })
        ],
      ),
      body: Center(
        child: _crearFlutterMap(scan,ymaxZoom)
      ),



    );
  }

  Widget _crearFlutterMap(ScanModel scan,double mymaxZoom) {

    return FlutterMap(
      mapController: mapCtrl,
      options: new  MapOptions(
        center: scan.getLatLng(),
        zoom: 16.0,
        maxZoom: 18.0,
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],

    );

  }

  _crearMapa(){

    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/styles/v1/'
            '{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
        additionalOptions: {
          'accessToken': 'pk.eyJ1Ijoibndvc3dvIiwiYSI6ImNrZDM1cW5uNTBuNjkyeW45emExNjE4aHcifQ.3pfXRGMt-48bcEG0cnC5Tw',
          'id': 'nwoswo/ckd3661713gcn1hqxs62jqs7y',
        },
    );


  }

  _crearMarcadores(ScanModel scan){

    return MarkerLayerOptions(
      markers: <Marker> [
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(Icons.location_on, size: 45.0,color: Theme.of(context).primaryColor,),
          )
        ),
        
      ]
    );

  }

}