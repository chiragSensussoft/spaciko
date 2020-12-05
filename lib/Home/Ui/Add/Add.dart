import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/Home/Ui/Add/steps/Step1.dart';
import 'package:spaciko/widgets/Pelette.dart';

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
  List<String> _stepText = ['1','2','3','4','5','6'];
  var activeColor = Pelette.ColorPrimaryDark;
  var inActiveColor = Pelette.colorGreenTrans;
  int _curStep =0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Pelette.ColorPrimaryDark,
        child: Column(
          children: [
            Container(
              color: Pelette.ColorPrimaryDark,
              height: MediaQuery.of(context).size.height *0.16,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Pelette.colorLightBlue50,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                child: Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: step(),
                      ),
                      Expanded(
                        child: Step1(),
                      )
                    ],
                  )
                ),
              ),
            )
          ],
        ),
      )
    );
  }

 List<Widget> step() {
   var list = <Widget>[];
    _stepText.asMap().forEach((i, value) {

      var circleColor =
      (i == 0 || _curStep > i + 1) ? activeColor : inActiveColor;

      list.add(
        Container(
          width: 30.0,
          height: 30.0,
          child: Center(child: Text(value,style: TextStyle(color: Colors.white),),),
          decoration: new BoxDecoration(
            color: circleColor,
            borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
          ),
        ),
      );
      if (i != _stepText.length - 1) {
        list.add(Expanded(
            child: Container(
              height: 2,
              color: Pelette.ColorPrimaryDark,
            )));
      }
    });
    return list;
  }

}