import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/Ui/Add/Add.dart';
import 'package:spaciko/Ui/Calender/Calender.dart';
import 'package:spaciko/Ui/Comment/Comment.dart';
import 'package:spaciko/Ui/Compass/Campass.dart';
import 'package:spaciko/Ui/Profile/Profile.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';

import '../BottomBar.dart';
import '../TopBarContent.dart';
import '../responsive.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int selectedIndex=2;
  var toast = Toast();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar:Responsive.isSmallScreen(context) ? PreferredSize(
       preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Pelette.ColorPrimaryDark,
        ),
      )
      :PreferredSize(
        preferredSize: Size(screenSize.width,screenSize.height),
        child: TopBarContent(),
      ),

       body: _widgetTransition.elementAt(selectedIndex),

       bottomNavigationBar: Responsive.isSmallScreen(context) ? SafeArea(
         top: true,
         bottom: true,
         child: CustomBottomBar(onChange: (val){
           setState(() {
             selectedIndex = val;
           });
         },),
       ) : null,
    );
  }

  List<Widget> _widgetTransition = [
    Container(
      child: CompassScreen(),
    ),
    Container(
      child: CalenderScreen(),
    ),
    Container(
      child: AddScreen(),
    ),
    Container(
      child: CommentScreen(),
    ),
    Container(
      child: Profile(),
    )
  ];
}