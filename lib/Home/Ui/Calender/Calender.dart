import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalenderScreen extends StatefulWidget {
  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child:Center(child:  Text('Calender'),)
        ),
      ),
    );
  }
}

