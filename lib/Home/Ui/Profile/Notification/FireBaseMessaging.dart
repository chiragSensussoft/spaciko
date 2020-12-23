import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FireBaseMessagingDemo extends StatefulWidget {
  FireBaseMessagingDemo() : super();
  @override
  _FireBaseMessagingDemoState createState() => _FireBaseMessagingDemoState();
}

class _FireBaseMessagingDemoState extends State<FireBaseMessagingDemo> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _getToken() {
    _firebaseMessaging.getToken().then((value) {
      print('Device Token: $value');
    });
  }

  List<Message> messagesList;

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
       _setMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
       _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _setMessage(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String mMessage = data['Message'];
    print("Title: $title, body: $body, message: ${mMessage??'Hello'}");
    setState(() {
      Message msg = Message(title, body, mMessage??'Hello');
      messagesList.add(msg);
    });
  }

  @override
  void initState() {
    super.initState();
    messagesList = List<Message>();
    _getToken();
    _configureFirebaseListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: null == messagesList ? 0 : messagesList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                messagesList[index].message,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

  class Message {
  String title;
  String body;
  String message;
  Message(title, body, message) {
  this.title = title;
  this.body = body;
  this.message = message;

  }
}
