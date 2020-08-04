
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
//ftDFhmQ0SdmkHJ4hrO39Qs:APA91bE_zgt__qZZ116cIPJBPh25WfbIXglrYU3tb7ioDOU7rWHGXAJEc6uV06CqMGj9YXiUN-4bCz37MonwN4iCRWrqNpxpTuRLtR8gWwIfvgd84GRzV4TYdWKzFaCqYUy3qkGiLpsN
class PushNotificationsProvider {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  //stream para escuchar notificaciones
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get getmensajesStream => _mensajesStreamController.stream;

  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async{
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }


  initNotifications() async {

    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );

    final token = await _firebaseMessaging.getToken();

    print('= FCM token ===');
    print(token);

    _firebaseMessaging.configure(
      onMessage:onMessage,
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch:onLaunch,
      onResume:onResume,
    );
    
  }

  //cuando la aplicaqcion esta habierta
  Future<dynamic> onMessage(Map<String, dynamic> message) async {

    print('=========On onMessage ======');
    print('message: $message');

    final argumento = message['data']['comida'] ?? 'no-data';

    //cualquier persona que este subsicrito a eso se va a enterar
    _mensajesStreamController.sink.add(argumento);
    // print('argumento: $argumento');
  
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {

    print('=========On onLaunch ======');
    print('message: $message');

    final argumento = message['data']['comida'] ?? 'no-data';
    _mensajesStreamController.sink.add(argumento);
    // print('argumento: $argumento');
  
  }

  //cuando la aplicacion esta en background
  Future<dynamic> onResume(Map<String, dynamic> message) async {

    print('=========On onResume ======');
    print('message: $message');

    final argumento = message['data']['comida'] ?? 'no-data';
    _mensajesStreamController.sink.add(argumento);
    // print('argumento: $argumento');
  
  }

  dispose() {
    _mensajesStreamController?.close();
  }



// _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
//         _showItemDialog(message);
//       },
//       onBackgroundMessage: myBackgroundMessageHandler,
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//         _navigateToItemDetail(message);
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//         _navigateToItemDetail(message);
//       },
//     );



}