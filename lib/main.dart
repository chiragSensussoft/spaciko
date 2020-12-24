import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'login/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: MyLogin(),
    );
  }

  getToken() async {
    String token = await _firebaseMessaging.getToken();
    print('Device Token: $token');
  }

}