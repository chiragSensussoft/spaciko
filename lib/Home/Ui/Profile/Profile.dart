import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spaciko/login/Login.dart';
import 'package:spaciko/widgets/Pelette.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Profile(),
      ),
    );
  }
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}
Future<dynamic> myBackgroundHandler(Map<String, dynamic> message) {
  return _ProfileState()._showNotification(message);
}

class _ProfileState extends State<Profile> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //Push Notification
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<NotificationMessage> messagesList;
  _getToken() {
    _firebaseMessaging.getToken().then((value) {
      print('Device Token: $value');
    });
  }

  Future _showNotification(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel desc',
      importance: Importance.max,
      priority: Priority.high,
    );
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String mMessage = data['Message'];
    // setState(() {
    //   Message msg = Message(title, body, mMessage??'Hello');
    //   messagesList.add(msg);
    // });
    var platformChannelSpecifics =
    new NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      '$title',
      '$body',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  getToken() async {
    String token = await _firebaseMessaging.getToken();
    print('Device Token: $token');
  }

  Future selectNotification(String payload) async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  // _configureFirebaseListeners() {
  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print('onMessage: $message');
  //       _setMessage(message);
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print('onLaunch: $message');
  //       _setMessage(message);
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print('onResume: $message');
  //       _setMessage(message);
  //     },
  //   );
  //   _firebaseMessaging.requestNotificationPermissions(
  //     const IosNotificationSettings(sound: true, badge: true, alert: true),
  //   );
  // }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String mMessage = data['Message'];
    print("Title: $title, body: $body, message: ${mMessage??'Hello'}");
    setState(() {
      NotificationMessage msg = NotificationMessage(title, body, mMessage??'Hello');
      messagesList.add(msg);
    });
  }

  SharedPreferences prefs;
  String name;
  String url;

  StreamSubscription iosSubscription;

  @override
  void initState(){
    super.initState();
    SharedPreferences.getInstance().then((value) => {
      SharedPreferences.getInstance().timeout(Duration(seconds: 3)),
      setState((){
        name = value.getString('name');
        url = value.getString('photoUrl');
      })
    });


    if (Platform.isIOS) {
      iosSubscription = _firebaseMessaging.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });

      _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings());
    }
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    super.initState();

    _firebaseMessaging.configure(
      onBackgroundMessage: myBackgroundHandler,
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _setMessage(message);
        // print(message);
        myBackgroundHandler(message);
      },
    );

    getToken();

    messagesList = List<NotificationMessage>();
    // _configureFirebaseListeners();
  }

  SharedPreferences _sharedPreferences;
  void _logout() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.remove('isLogin');
    await FacebookAuth.instance.logOut();
    Navigator.of(context,rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context)=> MyLogin()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.colorWhite,
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.white,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                        color: AppColors.colorPrimaryDark,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: Container(
                              height: 100,
                              width: 100,
                              child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(url ??
                                      'https://chiragkalathiya1111.000webhostapp.com/ic_defult.png')),
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (_){
                            return Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                              elevation: 16,
                              child: Container(
                                height: MediaQuery.of(context).size.height/3,
                                width: MediaQuery.of(context).size.width/2,
                                child:  ListView.builder(
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
                              ),
                            );
                          }
                      );
                    },
                    child: Container(
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(margin: const EdgeInsets.only(right: 15, bottom: 30),
                                    alignment: Alignment.center,
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Image.asset('image/ic_notification_white.png',width: 24,height: 24,),
                                        Positioned(
                                          right: 1,
                                          child: Container(
                                            transform:  Matrix4.translationValues(-2.0, -5.0, 1.0),
                                            alignment: Alignment.center,
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Text(messagesList.length.toString(),style: TextStyle(color: Colors.white,fontSize: 10),),
                                          ),
                                        ),
                                      ],
                                    )
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child:Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorWhite,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Text(name??'-'),
                        ),
                        Container(margin: const EdgeInsets.only(top: 20),
                          child: FlatButton(
                            height: 45,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            color: AppColors.colorPrimaryDark,
                            minWidth: MediaQuery.of(context).size.width /2,
                            onPressed: () => _logout(),
                            child:Text('My Profile',style: TextStyle(fontFamily: 'poppins_semibold',color: Colors.white,fontSize: 16),),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_){
                                  return Dialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                    elevation: 16,
                                    child: Container(
                                      height: MediaQuery.of(context).size.height/3,
                                      width: MediaQuery.of(context).size.width/2,
                                      child:  ListView.builder(
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
                                    ),
                                  );
                                }
                            );
                          },
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => Setting())),
                          child: Container(margin: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(margin:const EdgeInsets.only(left: 15),
                                      child: Image.asset('image/ic_settings.png',height: 30,width: 30,),
                                    ),
                                    Container(margin: const EdgeInsets.only(left: 20),
                                      child: Text('Settings',style: TextStyle(color: Colors.black,fontSize: 16),),
                                    )
                                  ],
                                ),
                                Container(margin:const EdgeInsets.only(right: 15),
                                  child: Image.asset('image/ic_rigthtback_green.png',height: 22,width: 22,),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(margin:const EdgeInsets.only(left: 15),
                                    child: Image.asset('image/ic_help.png',height: 30,width: 30,),
                                  ),
                                  Container(margin: const EdgeInsets.only(left: 20),
                                    child: Text('Help and Support',style: TextStyle(color: Colors.black,fontSize: 16),),
                                  )
                                ],
                              ),
                              Container(margin:const EdgeInsets.only(right: 15),
                                child: Image.asset('image/ic_rigthtback_green.png',height: 22,width: 22,),
                              )
                            ],
                          ),
                        ),
                        Container(margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(margin:const EdgeInsets.only(left: 15),
                                    child: Image.asset('image/ic_listing.png',height: 30,width: 30,),
                                  ),
                                  Container(margin: const EdgeInsets.only(left: 20),
                                    child: Text('My Listing',style: TextStyle(color: Colors.black,fontSize: 16),),
                                  )
                                ],
                              ),
                              Container(margin:const EdgeInsets.only(right: 15),
                                child: Image.asset('image/ic_rigthtback_green.png',height: 22,width: 22,),
                              )
                            ],
                          ),
                        ),
                        Container(margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(margin:const EdgeInsets.only(left: 15),
                                    child: Image.asset('image/ic_dispute.png',height: 30,width: 30,),
                                  ),
                                  Container(margin: const EdgeInsets.only(left: 20),
                                    child: Text('My Reservation',style: TextStyle(color: Colors.black,fontSize: 16),),
                                  )
                                ],
                              ),
                              Container(margin:const EdgeInsets.only(right: 15),
                                child: Image.asset('image/ic_rigthtback_green.png',height: 22,width: 22,),
                              )
                            ],
                          ),
                        ),
                        Container(margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(margin:const EdgeInsets.only(left: 15),
                                    child: Image.asset('image/ic_dispute.png',height: 30,width: 30,),
                                  ),
                                  Container(margin: const EdgeInsets.only(left: 20),
                                    child: Text('Dispute center',style: TextStyle(color: Colors.black,fontSize: 16),),
                                  )
                                ],
                              ),
                              Container(margin:const EdgeInsets.only(right: 15),
                                child: Image.asset('image/ic_rigthtback_green.png',height: 22,width: 22,),
                              )
                            ],
                          ),
                        ),
                        Container(margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(margin:const EdgeInsets.only(left: 15),
                                    child: Image.asset('image/ic_contect.png',height: 30,width: 30,),
                                  ),
                                  Container(margin: const EdgeInsets.only(left: 20),
                                    child: Text('Contact Us',style: TextStyle(color: Colors.black,fontSize: 16),),
                                  )
                                ],
                              ),
                              Container(margin:const EdgeInsets.only(right: 15),
                                child: Image.asset('image/ic_rigthtback_green.png',height: 22,width: 22,),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NotificationMessage {
  String title;
  String body;
  String message;
  NotificationMessage(title, body, message) {
    this.title = title;
    this.body = body;
    this.message = message;

  }
}