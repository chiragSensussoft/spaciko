import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spaciko/Home/Ui/Profile/Setting.dart';
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

class _ProfileState extends State<Profile> {

  SharedPreferences prefs;
  String name;
  String url;
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
                      child: Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                      child: Text('1',style: TextStyle(color: Colors.white,fontSize: 10),),
                                    ),
                                  ),
                                ],
                              )
                            )
                          ],
                        ),
                      )
                    ),
                     Container(
                       alignment: Alignment.bottomCenter,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(30)
                       ),
                       child: Container(
                         height: 100,
                         width: 100,
                         child: CircleAvatar(
                           backgroundColor: Colors.transparent,
                           backgroundImage: NetworkImage(url??'https://chiragkalathiya1111.000webhostapp.com/ic_defult.png')
                         ),
                       )
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
                          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => Setting())),
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
