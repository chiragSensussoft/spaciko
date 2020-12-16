import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spaciko/RegisterActivity/Register.dart';
import 'package:spaciko/intro/FirstIntro.dart';
import 'package:spaciko/utils/Validation.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';
import 'package:http/http.dart' as http;

class MyLogin extends StatefulWidget {

  @override
  _MyLoginState createState() => _MyLoginState();
}

SharedPreferences _sharedPreferences;

String email;
String psw;

class _MyLoginState extends State<MyLogin> {

  final _formKey = GlobalKey<FormState>();
@override
  void initState() {
    super.initState();
  }


  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(['email']);
    var graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookLoginResult
            .accessToken.token}');

    var profile = json.decode(graphResponse.body);
    print(profile.toString());

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: AppColors.colorPrimaryDark,
          )
      ),
      body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('image/login.png'),
                  fit: BoxFit.cover
              )
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(margin: const EdgeInsets.only(top: 80),
                    height: 130,
                    child: Image(
                      image: AssetImage('image/logo.png'),
                    ),
                  ),

                  Container(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          contentPadding: const EdgeInsets.fromLTRB(
                              20, 0, 20, 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))
                      ),
                      validator: (text) {
                        email = text.toString();
                        if (Validation.isEmailValid(text)) {
                          return 'Enter Valid Email';
                        }
                        else {
                          return null;
                        }
                      },
                    ),
                  ),

                  Container(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    margin: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      obscureText: true,
                      validator: (text) {
                        psw = text.toString();
                        if (Validation.isPswValid(text)) {
                          return 'Password must be more than 8 character';
                        }
                        else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Password',
                          contentPadding: const EdgeInsets.fromLTRB(
                              20, 0, 20, 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))
                      ),
                    ),
                  ),

                  Container(margin: const EdgeInsets.only(top: 10),
                    child: Text('Forgot Password', style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    height: 40,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xff18a499),
                      child: FlatButton(
                        onPressed: () {
                          var toast = Toast();
                          toast.overLay = false;
                          if (_formKey.currentState.validate()) {
                            checkUser(email, psw);
                            // Navigator.push(context, MaterialPageRoute(
                            //     builder: (context) => FirstIntro()
                            // ));
                            toast.showOverLay(_sharedPreferences.getString('email'),
                                Colors.white, Colors.black38, context);
                          }
                        },
                        minWidth: MediaQuery
                            .of(context)
                            .size
                            .width,
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text('Login', style: TextStyle(color: Colors
                            .white, fontSize: 17),),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                        'Sign In With'
                    ),
                  ),
                  Container(margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child:
                          GestureDetector(
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Image(height: 50,
                                image: AssetImage('image/facebook.png'),
                              ),
                            ),
                            onTap: initiateFacebookLogin,
                          ),
                        ),

                        Flexible(
                          child: GestureDetector(
                            child: Image(height: 48,
                              image: AssetImage('image/search.png'),
                            ),
                            onTap: (){
                              signInWithGoogle();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(margin: const EdgeInsets.only(top: 10),
                    child: RichText(
                      text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'Not a member? ', style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                            TextSpan(text: 'Register', style: TextStyle(
                                color: AppColors.colorPrimaryDark,
                                fontWeight: FontWeight.w500),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => Register()
                                    ));
                                  }
                            )
                          ]
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);



    print("Name :----->${user.displayName}");
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString('name', user.displayName);
    _sharedPreferences.setString('email1', user.email);
    _sharedPreferences.setString('photoUrl',user.photoUrl);
    print(_sharedPreferences.getString('name'));

    if(user!=null){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return FirstIntro();
          },
        ),
      );
    }

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  // Future<String> signInWithGoogle1() async {
  //   // await Firebase.initializeApp();
  //
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //
  //   final AuthResult authResult = await _auth.signInWithCredential(credential);
  //   final FirebaseUser user = authResult.user;
  //
  //   if (user != null) {
  //     // Checking if email and name is null
  //     assert(user.uid != null);
  //     assert(user.email != null);
  //     assert(user.displayName != null);
  //     assert(user.photoURL != null);
  //
  //
  //     assert(!user.isAnonymous);
  //     assert(await user.getIdToken() != null);
  //
  //     final User currentUser = _auth.currentUser;
  //     assert(user.uid == currentUser.uid);
  //
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setBool('auth', true);
  //
  //     return 'Google sign in successful, User UID: ${user.uid}';
  //   }
  //
  //   return null;
  // }



  checkUser(String email,String psw) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (email==_sharedPreferences.getString('email')||psw==_sharedPreferences.getString('password')) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FirstIntro()));
    }
    else{
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Register()));
    }
  }
}




