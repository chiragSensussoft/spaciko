import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Ui/Add/Add.dart';
import 'Ui/Calender/Calender.dart';
import 'Ui/Comment/Comment.dart';
import 'Ui/Compass/Campass.dart';
import 'Ui/Profile/Profile.dart';
import 'floating_quick_access_bar.dart';

class TopBarContent extends StatefulWidget {
  @override
  _TopBarContentState createState() => _TopBarContentState();
}

class _TopBarContentState extends State<TopBarContent> {
  int pageIndex =0;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width,screenSize.height),
        child: FloatingQuickAccessBar(screenSize: screenSize,onChange: (val){
          setState(() {
            pageIndex = val;
          });
        },),
      ),
      body: Container(
        child: _widgetTransition.elementAt(pageIndex)
      ),
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
