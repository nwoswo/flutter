import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Page')
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Mostrar Alerta'),
          color: Colors.blue,
          textColor: Colors.white,
          shape: StadiumBorder(), 
          onPressed: () => _mostrarAlert(context),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.keyboard_return),
        onPressed: () {
          Navigator.pop(context);
        }
      ),

    );
  }

  //Me gusta para mi es suficiente

  // void _mostrarAlert(BuildContext context) {

  //   showDialog(

  //     context: context,
  //     //cerrar cuando hace click afuera
  //     barrierDismissible: true,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Titulo'),
  //         content: Text('Dolore dolor elit veniam minim occaecat consequat minim laborum tempor aliquip aliquip elit. Velit id id sit ea proident. Qui est ad voluptate sunt consectetur mollit adipisicing mollit in eiusmod. Aliqua sint nulla officia quis ullamco deserunt laborum. Mollit voluptate labore nulla Lorem minim voluptate amet minim ut consequat sit cillum nulla qui. Adipisicing id cupidatat labore qui aliqua do ex do voluptate ut.'),
  //       );
  //     }

  //   );

  // }


  void _mostrarAlert(BuildContext context) {

    showDialog(

      context: context,
      //cerrar cuando hace click afuera
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Titulo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Dolore dolor elit veniam minim occaecat consequat minim laborum tempor aliquip aliquip elit. Velit id id sit ea proident. Qui est ad voluptate sunt consectetur mollit adipisicing mollit in eiusmod. Aliqua sint nulla officia quis ullamco deserunt laborum. Mollit voluptate labore nulla Lorem minim voluptate amet minim ut consequat sit cillum nulla qui. Adipisicing id cupidatat labore qui aliqua do ex do voluptate ut.'),
              FlutterLogo(size: 100.0 )
            ],
          ),

          actions: <Widget>[

            FlatButton(
                onPressed: (){
                  return Navigator.of(context).pop();
                }, 
                child: Text('Cancelar')
            ),

            FlatButton(
                onPressed: () =>  Navigator.of(context).pop(), 
                child: Text('Ok')
             )

          ],
        );
      }

    );

  }
}