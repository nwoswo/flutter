import 'package:flutter/material.dart';
import 'package:preferenciasuser/src/share_prefs/preferencias_usuario.dart';
import 'package:preferenciasuser/src/widgets/menu_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static final String routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _colorSecundario = false;
  int _genero = 1;
  // String _nombre = 'Pedro';

  TextEditingController _textController;

  //TODO  preferencias get Set
  final prefs = new Preferenciasusuario();
  
    //los estateful tienen init state
    @override
    void initState()  {
      super.initState();
      //get Genero de preferencias
      _genero = prefs.genero;
      _colorSecundario = prefs.colorSecundario;
      _textController= new TextEditingController( text: prefs.nombreUsuario);
    }
  
_setSelectedRadio(int valor) async {

  prefs.genero = valor;
  _genero = valor;
  setState(() {});
}
  
  @override
  Widget build(BuildContext context) {

    prefs.ultimaPagina = SettingsPage.routeName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      //TODO MENU1.1
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          Container(
            child: Text('Settings', style: TextStyle( fontSize: 45.0,fontWeight: FontWeight.bold ),),
            padding: EdgeInsets.all(5.0),
          ),

          Divider(),

          SwitchListTile(
            title: Text('Color secundario'),
            value: _colorSecundario, 
            onChanged: (value){ 
              
              setState(() {
                _colorSecundario = value;
                prefs.colorSecundario = value;
              });
            }
          ),

          RadioListTile(
            value: 1, 
            title: Text('Masculino'),
            groupValue: _genero, 
            // onChanged: (value){
            //   setState(() {
            //     _genero = value;

            //   });
            // }
            onChanged: _setSelectedRadio,
          ),

          RadioListTile(
            value: 2, 
            title: Text('Femenino'),
            groupValue: _genero, 
            // onChanged: (value){
            //   setState(() {
            //     _genero = value;
            //   });
            // }
            onChanged: _setSelectedRadio,
          ),

          Divider(),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona usando el telefono:'
              ),
              onChanged: (value) { 
                prefs.nombreUsuario = value;
              },
            ),
          )

        ],
      )
    );
  }
}
  
