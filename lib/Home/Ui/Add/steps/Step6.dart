import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';

class Step6 extends StatefulWidget {
  int curStep;
  Function(int) onChange;
  Step6({Key key,this.curStep,this.onChange}): super(key: key);
  @override
  _Step6State createState() => _Step6State();
}

class _Step6State extends State<Step6> {
  bool cb1 = false;
  bool cb2 = false;
  bool cb3 = false;
  bool cb4 = false;
  bool cb5 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text('How can guests access your space',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'poppins_semibold'),),
            ),
            Container(margin: const EdgeInsets.only(top: 30),
              child:_customCheckBox('Delivery access',cb1,(val)=>setState(()=>cb1=!val)),
            ),
            _customCheckBox('Garage Door',cb2,(val)=>setState(()=>cb2=!val)),
            _customCheckBox('Elevator',cb3,(val)=>setState(()=>cb3=!val)),
            _customCheckBox('Parking Near Ny',cb4,(val)=>setState(()=>cb4=!val)),
            _customCheckBox('Stairs',cb5,(val)=>setState(()=>cb5=!val)),

            Container(margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
              height: 40,
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                minWidth: MediaQuery.of(context).size.width,
                color: Pelette.ColorPrimaryDark,
                onPressed: (){
                  if(cb1==false&&cb2==false&&cb3==false&&cb4==false&&cb5==false){
                    Toast _toast = Toast();
                    _toast.overLay = false;
                    _toast.showOverLay('Select one', Colors.white, Colors.black54, context);
                  }
                },
                child: Text('Continue',style: TextStyle(color: Pelette.ColorWhite),),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _customCheckBox(String text,bool cb,Function onTap){
    return GestureDetector(
      child: Row(
        children: [
          Container(margin: const EdgeInsets.only(right: 2,left: 8,top: 15,bottom: 10),
            height: 20.0,
            width: 20.0,
            decoration:  BoxDecoration(
              color: cb
                  ? Pelette.ColorPrimaryDark
                  : Colors.white,
              borderRadius: const BorderRadius.all(const Radius.circular(30)),
            ),
          ),
          Text(text),
        ],
      ),
      onTap: () {
        onTap(cb);
      },
    );
  }
}