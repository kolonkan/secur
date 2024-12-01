import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/screens/splash_screen.dart';
import 'package:my_app/utils/KUtils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:my_app/acceuil/acceuil.dart';

import 'api/firebase_api.dart';
import 'api/notif_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAPI().initNotifications();
  //NotificationService().initNotification();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late WebSocketChannel webSocketChannel;
  late Stream<dynamic> streamBroadcast;

  @override
  void initState() {
    super.initState();
    webSocketChannel = WebSocketChannel.connect(Uri.parse(Kutils.ENDPOINT_WEBSOCKET_URI));
    streamBroadcast = webSocketChannel.stream.asBroadcastStream();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecurGuinee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/acceuil'  : (context) => Accueil (webSocketChannel: webSocketChannel,stream: streamBroadcast),
      },
    );
  }
}
