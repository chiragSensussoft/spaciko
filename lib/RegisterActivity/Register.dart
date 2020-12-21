import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spaciko/RegisterActivity/DBProvider.dart';
import 'package:spaciko/TandC/TermsAndConditon.dart';
import 'package:spaciko/intro/FirstIntro.dart';
import 'package:spaciko/login/Login.dart';
import 'package:spaciko/utils/Validation.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';
import 'package:sqflite/sqflite.dart';

class MyActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Register(),
    );
  }
}

class Register extends StatefulWidget{
  @override
  _RegisterState createState() => _RegisterState();
}
String email,psw,fname,lname;
bool isChecked;

class _RegisterState extends State<Register> {
  bool checkboxValue = false;
  final _formKey = GlobalKey<FormState>();

  SharedPreferences _sharedPreferences;

  Map<String, dynamic> _userData;
  AccessToken _accessToken;
  bool _checking = true;

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _fNameController = TextEditingController();
  final _lNameTextController = TextEditingController();

  final dbHelper = DatabaseHelper.instance;
  @override
  void initState() {
    _query();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: AppColors.colorPrimaryDark,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                Container(margin: const EdgeInsets.only(top: 25),
                 child: Image(
                    height: 100,
                   image: AssetImage('image/logo.png'),
                 ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Container( margin: const EdgeInsets.only(top: 20,left: 20,right: 5),
                        child: TextFormField(
                          controller: _fNameController,
                          decoration: InputDecoration(
                              labelText: 'First Name',
                              contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))
                          ),
                          validator: (text){
                            if(Validation.isNameEmpty(text)){
                              return 'Enter First Name';
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container( margin: const EdgeInsets.only(top: 20,right: 20,left: 5),
                        child: TextFormField(
                          controller: _lNameTextController,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                              contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))
                          ),
                          validator: (text){
                            if(Validation.isNameEmpty(text)){
                              return 'Enter Last Name';
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Container(margin: const EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: TextFormField(
                    controller: _emailTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)
                      ),
                      labelText: 'Email',
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0)
                    ),
                    validator: (value){
                      email = value;
                      if(Validation.isEmailValid(value)){
                        return 'Enter valid Email';
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                ),
                Container(margin: const EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: TextFormField(
                    controller: _passwordTextController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        labelText: 'Password',
                        contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0)
                    ),
                    validator: (text){
                      psw = text;
                      if(Validation.isPswValid(text)){
                        return 'Password must be more than 8 character';
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                ),
                Container(margin: const EdgeInsets.only(top: 10,left: 20),

                child:
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new  GestureDetector(
                        onTap: () {
                          setState(() {
                            checkboxValue = !checkboxValue;
                            if(Validation.tAndC(checkboxValue)){
                              return 'Please Accept our Terms And Condition';
                            }else{
                              return null;
                            }
                          });
                        },
                        child: checkboxValue
                            ? Icon(
                          Icons.radio_button_checked,
                          color: AppColors.colorPrimaryDark,
                          size: 20,
                        )
                            : Icon(
                          Icons.radio_button_unchecked,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 5),

                      Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: 'By signing up spaciko\'s ',style: TextStyle(color: Colors.black)),
                                TextSpan(text: 'Terms and Condition,',style: TextStyle(color: AppColors.colorPrimaryDark, fontWeight: FontWeight.bold)
                                ,recognizer: TapGestureRecognizer()
                                    ..onTap =(){
                                        Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => TandC()
                                        ));
                                    }
                                ),
                                TextSpan(text: 'Privacy Policy Guest Refund,consent disagree',style: TextStyle(color: Colors.black))
                              ]
                            ),
                          )
                      )
                    ],
                  ),
                ),
                Container(margin: const EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: Material(
                      color: AppColors.colorPrimaryDark,
                      borderRadius: BorderRadius.circular(25),
                      child: FlatButton(
                        onPressed: (){
                          _insert();
                          // if(_formKey.currentState.validate()){
                          //     var toast = Toast();
                          //     toast.overLay = false;
                          //     addStringToSF();
                          //     // toast.showOverLay(prefs.getString('email'), Colors.black, Colors.black38, context);
                          //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyLogin()));
                          // }
                      },
                      minWidth: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Text('Sign Up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                  )
                ),
                Container(margin: const EdgeInsets.only(top: 10),
                  child: Text('Sign In With'),
                ),
                Container(margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _login,
                        child: Container(margin: const EdgeInsets.only(right: 5),
                          child: Image(
                            image: AssetImage('image/facebook.png'),
                            height: 40,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: signInWithGoogle,
                        child: Container(margin: const EdgeInsets.only(left: 5),
                          child: Image(
                            image: AssetImage('image/search.png'),
                            height: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(margin: const EdgeInsets.only(top: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'Already have an account? ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 15)),
                        TextSpan(text: 'Log In',style: TextStyle(color: AppColors.colorPrimaryDark,fontWeight: FontWeight.w400,fontSize: 17)
                          ,recognizer: TapGestureRecognizer()
                            ..onTap =(){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => MyLogin()
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
        ),
      ),
    );
  }

  SharedPreferences prefs;
  addStringToSF() async {
     prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
     prefs.setString('[password]', psw);
  }

  void _insert() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnfName : _fNameController.text,
      DatabaseHelper.columnlName : _lNameTextController.text,
      DatabaseHelper.columnEmail : _emailTextController.text,
      DatabaseHelper.columnPassword : _passwordTextController.text,
      DatabaseHelper.columnIsLoginWith : 'Google',
    };

    final data = await dbHelper.select(_emailTextController.text);
    data.forEach((element) {
      if(element['email'] != _emailTextController.text){
        dbHelper.insert(row);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyLogin()));
      }else{
        Toast toast = Toast();
        toast.overLay = false;
        toast.showOverLay('User Exist', Colors.white, Colors.black54, context);
      }
    });

  }

  void update(String fName,String lName,String email,String pass,String loginType) async{
    Map<String, dynamic> row = {
      DatabaseHelper.columnfName : fName,
      DatabaseHelper.columnlName : lName,
      DatabaseHelper.columnEmail : email,
      DatabaseHelper.columnPassword : pass,
      DatabaseHelper.columnIsLoginWith : loginType,
    };
    final data = await dbHelper.select(email);

    data.forEach((element) {
      if(element['email'] == email){
        dbHelper.update(row,element['_id']);
        print(element);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FirstIntro()));
      }else{
        Toast toast = Toast();
        toast.overLay = false;
        toast.showOverLay('User Exist', Colors.white, Colors.black54, context);
      }
    });

  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) {
      print(row);
      print('User Name is ${row[DatabaseHelper.columnfName]}');
      return null;
    });
  }

  //Google Sign In
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

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

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    final idToken = googleSignInAuthentication.idToken;

    Map<String, dynamic> idMap = parseJwt(idToken);

    final String firstName = idMap["given_name"];
    final String lastName = idMap["family_name"];

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);


    //Shared Preferences
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString('name', user.displayName);
    _sharedPreferences.setString('email1', user.email);
    _sharedPreferences.setString('photoUrl',user.photoUrl);
    print(_sharedPreferences.getString('name'));

    //Using Sqflite Database

    if(user!=null){
      update(firstName, lastName, user.email, '', 'Google');
    }

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  void isLogin(bool isLogin) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool('isLogin', isLogin);
  }

  /// Facebook signIn

  Future<void> _checkIfIsLogged() async {
    final AccessToken accessToken = await FacebookAuth.instance.isLogged;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      final userData = await FacebookAuth.instance.getUserData();
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
      _accessToken = await FacebookAuth.instance.login();
      _printCredentials();
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FirstIntro()));
      isLogin(true);
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

}