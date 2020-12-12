import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';


class Step4 extends StatefulWidget {
  int curStep;
  Function(int) onChange;
  Step4({Key key,this.curStep,this.onChange}): super(key: key);
  @override
  _Step4State createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checkboxValue4 = false;
  bool checkboxValue5 = false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(margin: const EdgeInsets.only(top: 20),
              child: Text('Please Select all of the amenities that can be found in your space. tick as few or more as are relevant',
                  textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontFamily: 'poppins_semibold',fontSize: 15),),
            ),
            Container(margin: const EdgeInsets.only(top: 20),
              child: _customCheckBox('Body Temperature Thermometer',checkboxValue1,(val)=>setState(()=>checkboxValue1 =! val)),
            ),
            Container(margin: const EdgeInsets.only(top: 20),
              child: _customCheckBox('Hand sanitizer',checkboxValue2,(val)=>setState(()=>checkboxValue2 =! val)),
            ),
            Container(margin: const EdgeInsets.only(top: 20),
              child: _customCheckBox('Air Condition',checkboxValue3,(val)=>setState(()=>checkboxValue3 =! val)),
            ),
            Container(margin: const EdgeInsets.only(top: 20),
              child: _customCheckBox('ADSl Internet',checkboxValue4,(val)=>setState(()=>checkboxValue4 =! val)),
            ),
            Container(margin: const EdgeInsets.only(top: 20),
              child: _customCheckBox('Wireless Internet',checkboxValue5,(val)=>setState(()=>checkboxValue5 =! val)),
            ),
            Container(margin: const EdgeInsets.only(top: 30,left: 20,right: 20),
              height: 40,
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                minWidth: MediaQuery.of(context).size.width,
                color: AppColors.colorPrimaryDark,
                onPressed: (){
                  if(checkboxValue1== false&&checkboxValue2== false&&checkboxValue3== false&&checkboxValue4== false
                      &&checkboxValue5== false) {
                    Toast _toast = Toast();
                    _toast.overLay = false;
                    _toast.showOverLay('Select at least one', Colors.white, Colors.black54, context);
                  }else{
                    widget.onChange(widget.curStep);
                  }
                },
                child: Text('Continue',style: TextStyle(color: AppColors.colorWhite),),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _customCheckBox(String text,bool cb,Function onTap){
    return GestureDetector(
      child: Row(
        children: [
          Container(margin: const EdgeInsets.only(right: 2,left: 8),
            height: 20.0,
            width: 20.0,
            decoration:  BoxDecoration(
              color: cb
                  ? AppColors.colorPrimaryDark
                  : Colors.white,
              borderRadius: const BorderRadius.all(const Radius.circular(30)),
            ),
          ),
          Text(text,overflow: TextOverflow.ellipsis),
        ],
      ),
      onTap: () {
        onTap(cb);
      },
    );
  }

}
