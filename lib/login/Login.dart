import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spaciko/RegisterActivity/DBProvider.dart';
import 'package:spaciko/RegisterActivity/Register.dart';
import 'package:spaciko/intro/FirstIntro.dart';
import 'package:spaciko/login/forgot%20password/ForgotPassword.dart';
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
bool idLogin;

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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final firebaseInstance = FirebaseDatabase.instance.reference();
  DatabaseReference databaseReference1;
  String dToken;
  @override
  void initState() {
    super.initState();
    _checkIfIsLogged();
    _checkIsLogin();
    getToken();
  }
  getToken() async {
    String token = await _firebaseMessaging.getToken();
    dToken = token;
  }

  void createData(String userName,String token){
    // databaseReference1.child('UserDetail');
    databaseReference1 = firebaseInstance.child('userDetail').child(userName);
    databaseReference1.set({
      "deviceToken": token
    });
  }

  void _checkIsLogin()async{
    _sharedPreferences = await SharedPreferences.getInstance();
      if (_sharedPreferences.getBool('isLogin')== true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FirstIntro()));
      }
  }

  //SqLite get data
  final dbHelper = DatabaseHelper.instance;

  Future<void> _checkIfIsLogged() async {
    final AccessToken accessToken = await FacebookAuth.instance.isLogged;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }

  void _printCredentials() {
    // print(
    //   prettyPrint(_accessToken.toJson()),
    // );
  }

  Future<void> _login() async {
    try {
      setState(() {
        _checking = true;
      });


      _accessToken = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      var graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.width(200)&access_token=${_accessToken.token}');

      var profile = json.decode(graphResponse.body);
      // Update And Insert Records
      update(profile['first_name'], profile['last_name'], profile['email'],'', 'FaceBook');
      createData(profile['name'], dToken);
      print('Login Successful');
    } on FacebookAuthException catch (e) {
      print('${e.message}');
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
      print(e);
      print(s);
    } finally {
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
                  fit: BoxFit.fill
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

                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword())),
                    child: Container(margin: const EdgeInsets.only(top: 10),
                      child: Text('Forgot Password', style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      ),
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
                          if (_formKey.currentState.validate()) {
                            _loginWithDatabase();
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
                            onTap: (){
                              // dbHelper.delete(2);
                              _login();
                              _query();
                            },
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

  void update(String fName,String lName,String email,String pass,String loginType) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnfName: fName,
      DatabaseHelper.columnlName: lName,
      DatabaseHelper.columnEmail: email,
      DatabaseHelper.columnPassword: pass,
      DatabaseHelper.columnIsLoginWith: loginType,
    };

    final data = await dbHelper.select(email);

    if (data.length != 0) {
          dbHelper.update(row, data[0]['_id']);
          isLogin(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => FirstIntro()));
    }
    else {
      insertWithSocial(fName, lName, email, pass, loginType);
      isLogin(true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FirstIntro()));
    }
  }

    void insertWithSocial(String fName,String lName,String email,String pass,String loginType){
      Map<String, dynamic> row = {
        DatabaseHelper.columnfName : fName,
        DatabaseHelper.columnlName : lName,
        DatabaseHelper.columnEmail : email,
        DatabaseHelper.columnPassword : pass,
        DatabaseHelper.columnIsLoginWith : loginType,
      };
      dbHelper.insert(row);
    }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ["email", "https://www.googleapis.com/auth/user.birthday.read", "https://www.googleapis.com/auth/userinfo.profile"]
  );

  static Map<String, dynamic> parseJwt(String token) {
    if (token == null) return null;
    final List<String> parts = token.split('.');
    if (parts.length != 3) {
      return null;
    }
    final String payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }
    return payloadMap;
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final idToken = googleSignInAuthentication.idToken;

    Map<String, dynamic> idMap = parseJwt(idToken);

    final String firstName = idMap["given_name"];
    final String lastName = idMap["family_name"];

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

    print("FirstName :--->${firstName+"\nLastName ---> "+ lastName}");
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString('name', user.displayName);
    _sharedPreferences.setString('email1', user.email);
    _sharedPreferences.setString('photoUrl',user.photoUrl);

    if(user!=null){
      update(firstName, lastName, user.email, '', 'Google');
      createData(user.displayName,dToken);
    }
    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();
    print("User Sign Out");
  }

  void _loginWithDatabase() async {
    final data = await dbHelper.select(_emailTextController.text);

    if(data.length != 0){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FirstIntro()));
      isLogin(true);
    }else{
      Toast toast = Toast();
      toast.overLay = false;
      toast.showOverLay('User Does\'t Exist', Colors.white, Colors.black54, context);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Register()
      ));
    }
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
  // checkUser(String email,String psw) async {
  //   _sharedPreferences = await SharedPreferences.getInstance();
  //   if (email==_sharedPreferences.getString('email')||psw==_sharedPreferences.getString('password')) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => FirstIntro()));
  //   }
  //   else{
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => Register()));
  //   }
  // }


  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) {
      print(row);
    });
  }

  void isLogin(bool isLogin) async {
   _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool('isLogin', isLogin);
  }
}