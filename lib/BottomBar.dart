import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomBottomBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;

  CustomBottomBar({this.defaultSelectedIndex,@required this.onChange});

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndex =0;


  @override
  void initState() {
    _selectedIndex = widget.defaultSelectedIndex;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 50,
        color: Colors.white,
        child: Row(
          children: [
            NavBarItem(AssetImage('image/ic_campas.png'),AssetImage('image/ic_campas_themecolor.png'),0,true,35),
            NavBarItem(AssetImage('image/ic_calender.png'),AssetImage('image/ic_calender_green.png'),1,false,35),
            NavBarItem(AssetImage('image/ic_add.png'),AssetImage('image/ic_add.png'),2,false,45),
            NavBarItem(AssetImage('image/ic_comment.png'),AssetImage('image/ic_comment_themecolor.png'),3,false,35),
            NavBarItem(AssetImage('image/ic_user.png'),AssetImage('image/ic_user_themecolor.png'),4,false,35),
          ],
        ),
      ),
    );
  }
  Widget NavBarItem(AssetImage deActive,AssetImage activeAssetImage,int index,bool isActive,double height){
    return GestureDetector(
      onTap: (){
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width/5,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: index == _selectedIndex ? activeAssetImage : deActive
            )
        ),
      ),
    );
  }

}