import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/RegisterActivity/DBProvider.dart';
import 'package:spaciko/RegisterActivity/Register.dart';
import 'package:spaciko/utils/Validation.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';

import '../Login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final dbHelper = DatabaseHelper.instance;

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confromPasswordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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

                  Container(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    margin: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      obscureText: true,
                      controller: _confromPasswordTextController,
                      validator: (text) {
                        if (Validation.isPswValid(text)) {
                          return 'Password must be more than 8 character';
                        }
                        else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Conform Password',
                          contentPadding: const EdgeInsets.fromLTRB(
                              20, 0, 20, 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))
                      ),
                    ),
                  ),

                  Container(margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                    height: 40,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xff18a499),
                      child: FlatButton(
                        onPressed: () {
                          update(_emailTextController.text,_passwordTextController.text,_confromPasswordTextController.text);
                          _query();
                        },
                        minWidth: MediaQuery
                            .of(context)
                            .size
                            .width,
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text('Reset Password', style: TextStyle(color: Colors
                            .white, fontSize: 17),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

  void update(String email,String pass,String conPass) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnEmail: email,
      DatabaseHelper.columnPassword: pass,
      DatabaseHelper.columnIsLoginWith: 'Normal',
    };
    final data = await dbHelper.select(email);
    if (data.length != 0) {
     if(pass == conPass){
       dbHelper.update(row, data[0]['_id']);
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyLogin()));
     }
     else{
       var toast = Toast();
       toast.overLay = false;
       toast.showOverLay('Password Not Match', Colors.white, Colors.black54, context);
     }
    }
    else {
      var toast = Toast();
      toast.overLay = false;
      toast.showOverLay('Email Not Match', Colors.white, Colors.black54, context);
    }
  }



  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) {
      print(row);
    });
  }
}
