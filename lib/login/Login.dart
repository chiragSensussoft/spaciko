
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spaciko/RegisterActivity/DBProvider.dart';
import 'package:spaciko/RegisterActivity/Register.dart';
import 'package:spaciko/intro/FirstIntro.dart';
import 'package:spaciko/utils/Validation.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';

class MyLogin extends StatefulWidget {

  @override
  _MyLoginState createState() => _MyLoginState();
}

SharedPreferences _sharedPreferences;

String email;
String psw;

String prettyPrint(Map json) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class _MyLoginState extends State<MyLogin> {

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _userData;
  AccessToken _accessToken;
  bool _checking = true;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _checkIfIsLogged();
    //isLogin();
  }


  //SqLite get data
  final dbHelper = DatabaseHelper.instance;


  Future<void> _checkIfIsLogged() async {
    final AccessToken accessToken = await FacebookAuth.instance.isLogged;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }

  void _printCredentials() {
    print(
      prettyPrint(_accessToken.toJson()),
    );
  }

  Future<void> _login() async {
    try {
      setState(() {
        _checking = true;
      });
      _accessToken = await FacebookAuth.instance.login(); // by the fault we request the email and the public profile
      // loginBehavior is only supported for Android devices, for ios it will be ignored
      // _accessToken = await FacebookAuth.instance.login(
      //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
      //   loginBehavior:
      //       LoginBehavior.DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
      // );
      _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
    } on FacebookAuthException catch (e) {
      // if the facebook login fails
      print(e.message); // print the error message in console
      // check the error type
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
    } catch (e, s) {
      // print in the logs the unknown errors
      print(e);
      print(s);
    } finally {
      // update the view
      setState(() {
        _checking = false;
      });
    }
  }


  Future<void> _logOut() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
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
                      controller: _emailTextController,
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
                      controller: _passwordTextController,
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
                            //checkUser(email, psw);
                            //isLogin();
                            _query(_emailTextController.text,_passwordTextController.text);
                            print(_emailTextController.text+"     "+_passwordTextController.text);
                            // toast.showOverLay(_sharedPreferences.getString('email'),
                            //     Colors.white, Colors.black38, context);
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
                            onTap: _login,
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

  void _query(String email,String pass) async {
    final allRows = await dbHelper.queryAllRows();

    allRows.forEach((row) {
      print(row);
      print('User Name is ${row[DatabaseHelper.columnfName]}');
      if(email == row[DatabaseHelper.columnEmail]|| pass == row[DatabaseHelper.columnPassword]){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FirstIntro()));
      }
      else{
        Toast t = Toast();
        t.overLay = false;
        t.showOverLay('Something went wrong', Colors.white, Colors.black54, context);
      }
    });
  }

  void isLogin() async {
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) {
      print(row[DatabaseHelper.columnEmail]);
      // if(row[DatabaseHelper.columnIsLoginWith] == 'True'){
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => FirstIntro()));
      // }
      return null;
    });
  }

}




