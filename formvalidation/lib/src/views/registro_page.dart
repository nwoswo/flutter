import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider_inhered.dart';
import 'package:formvalidation/src/providers/usuario_provider.dart';
import 'package:formvalidation/src/utils/utils.dart';


class RegistroPage extends StatelessWidget {

  final usuarioProvider  = new UsuarioProvider();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _registerForm(context),
        ],
      ),
    );
  }

  Widget _registerForm(BuildContext context){

    //TODO provider inhered 1.1
    final bloc = ProviderIngered.of(context);


    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(child: Container(height: 220.0,)),
          Container(
            width: size.width * 0.80,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow> [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0,5.0),
                  spreadRadius: 3.0
                )
              ]

            ),
            child: Column(
              children: <Widget>[
                Text('Crear cuenta', style: TextStyle(fontSize: 20.0),),
                SizedBox(height: 5.0,),
                _crearEmail(bloc),
                _crearPassword(bloc),
                SizedBox(height: 25.0,),
                _crearBoton(bloc)
              ],
            ),
          ),
          
          FlatButton(
            onPressed: () => Navigator.pushNamed(context, 'login'), 
            child: Text('Ya tienes cuenta ? ')
          ),

          SizedBox(height: 100.0,)
        ],

       

      ),
    );

  }

  Widget _crearEmail(LoginBloc block){


    

    //ahora tenemos la capacidad de escuchar los cambios en el textFiel  -> Onchanged
    return StreamBuilder(
      stream: block.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple,),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electronico',
              errorText: snapshot.error
            ),
            //cada ves que la persona escriba envia el valor al Stream
            //TODO provider inhered 1.2
            onChanged: (value) => block.changeEmail(value), 
          ),
        );
      },
    );
    

  }

  Widget _crearPassword(LoginBloc block){

    return StreamBuilder(
      stream: block.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.deepPurple,),
              labelText: 'Password',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: block.changePassword,
          ),
        );
      },
    );

    
  }


  Widget _crearBoton(LoginBloc block){

    //como obtener el ultimo valor enviado al Stream
    //TODO Convine Stream 1.1
  _register(LoginBloc block,BuildContext context) async  {

    print('=====');
    print('Email: ${block.getemail}');
    print('Email: ${block.getpassword}');

    final info = await usuarioProvider.nuevoUsuario(block.getemail, block.getpassword);
    if( info['ok'] ) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      mostrarAlerta(context, info['message']);
    }
    // Navigator.pushNamed(context, 'home');

  }


    return StreamBuilder(
      stream: block.formValidStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData? () {return _register(block,context);}: null
        );
      },
    );

    
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
          ]
        )
      ),
    );

    final cirulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255,255,255, 0.05)
      ),
    );


    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned( top: 90.0, left: 30.0, child: cirulo ),
        Positioned( top: -40.0, left: -30.0, child: cirulo ),
        Positioned( top: -30.0, right: -10.0, child: cirulo ),
        Positioned( top: 200, right: 20.0, child: cirulo ),
        Positioned( bottom: 120.0, right: 20.0, child: cirulo ),
        
        Container(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0,),
              SizedBox(height: 10.0,width: double.infinity,),
              Text('Fernando Herrera', style: TextStyle(color: Colors.white, fontSize: 30.0),)
            ],
          ),
        )


      ],
    );
  }

}