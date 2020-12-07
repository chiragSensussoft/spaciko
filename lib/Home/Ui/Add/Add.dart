import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/Home/Ui/Add/steps/Step1.dart';
import 'package:spaciko/Home/Ui/Add/steps/Step2.dart';
import 'package:spaciko/Home/Ui/Add/steps/Step3.dart';
import 'package:spaciko/Home/Ui/Add/steps/Step4.dart';
import 'package:spaciko/widgets/Pelette.dart';

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AddScreen(),);
  }
}

class AddScreen extends StatefulWidget{
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen>{
  List<String> _stepText = ['1','2','3','4','5','6'];
  var activeColor = Pelette.ColorPrimaryDark;
  var inActiveColor = Pelette.colorGreenTrans;
  int _curStep =0;
  @override
  void initState() {
    step();
    //_pageStep();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Pelette.ColorPrimaryDark,
        child: Column(
          children: [
            Container(
              color: Pelette.ColorPrimaryDark,
              height: MediaQuery.of(context).size.height * 0.16,
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
                        child: setps(),
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
      (i == _curStep) ? activeColor : inActiveColor;

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

  Widget _pageStep() {
    return PageView.builder(
      itemCount: _widgetTransition.length,
      itemBuilder: (_,index){
        return Container(
          child: _widgetTransition.elementAt(index),
        );
      },
       onPageChanged: (int index) => setState(() => _curStep = index),
    );
  }

  List<Widget> _widgetTransition = [
    Container(
      child: Step1(),
    ),
    Container(
      child: Step2(),
    ),
  ];

  Widget setps() {
    if(_curStep ==0){
      return Step1(curStep: 1,onChange: (val) => setState(()=>_curStep = val));
    }
    if(_curStep==1){
      return Step2(curStep: 2,onChange: (val) => setState(()=>_curStep = val));
    }
    if(_curStep==2){
      return Step3(curStep: 3,onChange: (val) => setState(()=>_curStep = val));
    }
    if(_curStep==3){
      return Step4(curStep: 4,onChange: (val) => setState(()=>_curStep = val));
    }
  }

}