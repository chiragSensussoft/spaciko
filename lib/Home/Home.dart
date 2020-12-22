import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';

import 'BottomBar.dart';
import 'TopBarContent.dart';
import '../widgets/responsive.dart';
import 'Ui/Add/Add.dart';
import 'Ui/Calender/Calender.dart';
import 'Ui/Comment/Comment.dart';
import 'Ui/Compass/Campass.dart';
import 'Ui/Profile/Profile.dart';

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
  int selectedIndex=1;
  var toast = Toast();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar:Responsive.isSmallScreen(context) ? PreferredSize(
       preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: AppColors.colorPrimaryDark,
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
         },defaultSelectedIndex: 1,),
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
      child: MyScreen(),
    )
  ];
}