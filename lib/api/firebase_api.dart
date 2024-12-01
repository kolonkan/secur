import 'package:firebase_messaging/firebase_messaging.dart';

import '../service/django_service.dart';

class FirebaseAPI{
  //create an instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notification
  Future<void> initNotifications() async{
    //request permissions from user (will prompt user)
    await _firebaseMessaging.requestPermission();

    //fetch the fcm token for this device
    final fCMToken = await _firebaseMessaging.getToken();

    //print the token (normally you would send this to your server)
    print('token: ${fCMToken.toString()}' );
    APIService.api_update_token_firebase(fCMToken.toString()).then((result){
      print("token registred successfully");
    });

    //initialize further settings for push notification
    initPushNotifications();
  }

  //function to handle received messages
  void handleMessage(RemoteMessage? message){
    //if the message is null
    if( message == null ) return;

    //navigate to new screen when message is received was user taps notification
  }

  //function to initialize and background settings
  Future initPushNotifications()async{
    //handle notification if the app was terminated and now oppended
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}

