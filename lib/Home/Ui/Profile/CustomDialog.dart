import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class Consts{
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class PushNotifyManager {

  PushNotifyManager ._();

  factory PushNotifyManager () => _instance;

  static final PushNotifyManager _instance = PushNotifyManager ._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<PushNotifyManager > init()async{
    if (Platform.isIOS) {
      await _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
      );
    }

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    String token = await _firebaseMessaging.getToken();
    return this;
  }
}