import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/Home/Ui/Add/steps/Publish.dart';
import 'package:spaciko/Home/Ui/Add/steps/Step1.dart';
import 'package:spaciko/Home/Ui/Add/steps/Step2.dart';
import 'package:spaciko/Home/Ui/Add/steps/Step3.dart';
import 'package:spaciko/Home/Ui/Add/steps/Step4.dart';
import 'package:spaciko/Home/Ui/Add/steps/Step5.dart';
import 'package:spaciko/Home/Ui/Add/steps/Step6.dart';
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
  var activeColor = AppColors.colorPrimaryDark;
  var inActiveColor = AppColors.colorGreenTrans;
  int _curStep =6;
  @override
  void initState() {
    step();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.colorPrimaryDark,
        child: Column(
          children: [
            Container(padding: const EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              color: AppColors.colorPrimaryDark,
              height: MediaQuery.of(context).size.height * 0.14,
              child: GestureDetector(
                child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
                onTap: (){
                  setState(() {
                    _curStep >0? _curStep -=1: null;
                  });
                },
              )
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.colorLightBlue50,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                child: Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
                  width: MediaQuery.of(context).size.width,
                  child:_curStep!=6?Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: step(),
                      ),
                      Expanded(
                        child: setps(),
                      )
                    ],
                  ): Publish(),
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
              color: AppColors.colorPrimaryDark,
            )));
      }
    });
    return list;
  }

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
    if(_curStep==4){
      return Step5(curStep: 5,onChange: (val) => setState(()=>_curStep = val));
    }
    if(_curStep==5){
      return Step6(curStep: 6,onChange: (val) => setState(()=>_curStep = val));
    }
  }
}