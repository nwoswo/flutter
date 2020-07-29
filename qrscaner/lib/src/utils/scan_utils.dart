import 'package:flutter/material.dart';
import 'package:qrscaner/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';






launchURL(BuildContext context,ScanModel scan) async {  //-> no  puede ser privado

  if( scan.tipo == 'http' ) {
    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'Could not launch ${scan.valor}';
    }
  }else{
    Navigator.pushNamed(context, 'mapa',arguments: scan);
  }

  
  
}
