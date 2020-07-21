import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: <Widget>[

          Container(
            margin: EdgeInsets.all(5.0),
            child: ClipOval(
                child: Image.asset('assets/st.jpg'),
                
              ),
          ),
          


          Container(
            margin: EdgeInsets.all(7.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/st.jpg'),
              radius: 25.0,
            ),
          ),

          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text('SL'),
              backgroundColor: Colors.brown,
            ),
          )
        ],
      ),

      body: Center(
        child: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          // image: NetworkImage('url'),
          image: AssetImage('assets/st2.jpg'),
          fadeInDuration: Duration( milliseconds: 30000 ),
        )
      ),
    );
  }
}