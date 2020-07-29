import 'package:flutter/material.dart';
import 'package:preferenciasuser/src/views/home_page.dart';
import 'package:preferenciasuser/src/views/settings_page.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
  
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/menu-img.jpg'),
              fit: BoxFit.cover  
            ),
            ),
          ),

          //Opciones del Memu

          ListTile(
            leading: Icon(Icons.pages, color: Theme.of(context).primaryColor),
            title: Text('Home'),
            onTap: () => Navigator.pushReplacementNamed(context, HomePage.routeName),
          ),

          ListTile(
            leading: Icon(Icons.party_mode, color: Theme.of(context).primaryColor),
            title: Text('party Mode'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.people, color: Theme.of(context).primaryColor),
            title: Text('People'),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.settings, color: Theme.of(context).primaryColor),
            title: Text('Settings'),
            onTap: () { 
              Navigator.pop(context);
              //es como que borra el historial de navegacion
              Navigator.pushReplacementNamed(context, SettingsPage.routeName); 
            },
          ),

       

        ],
      ),
    );
  }
  
}