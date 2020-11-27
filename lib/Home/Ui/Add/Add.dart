import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AddScreen(),);
  }
}

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Add',style: TextStyle(fontFamily: 'poppins_semibold'),),
      ),
    );
  }
}