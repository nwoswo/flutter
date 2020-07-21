
import 'package:componentes/src/pages/lista_pull.dart';
import 'package:componentes/src/pages/listview_page.dart';
import 'package:componentes/src/pages/slider_page.dart';
import 'package:flutter/material.dart';

import 'package:componentes/src/pages/alert_page.dart';
import 'package:componentes/src/pages/avatar_page.dart';
import 'package:componentes/src/pages/home_page.dart';
import 'package:componentes/src/pages/card_page.dart';
import 'package:componentes/src/pages/input_page.dart';

Map<String,WidgetBuilder> getAplicacionRoutes() {

  return <String, WidgetBuilder> {
    '/'       : (BuildContext context) => HomePage(),
    'alert'   : (BuildContext context) => AlertPage(),
    'avatar'  : (BuildContext context) => AvatarPage(),
    'card'    : (BuildContext context) => Cardpage(),
    'inputs'  : (BuildContext context) => InputPage(),
    'slider'  : (BuildContext context) => SliderPage(),
    'list'    : (BuildContext context) => ListaPage(),
    'listPull'    : (BuildContext context) => ListaPull()
    
          
  };
}

