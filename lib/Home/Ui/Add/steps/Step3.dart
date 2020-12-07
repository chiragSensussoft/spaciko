import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';

class Step3 extends StatefulWidget {
  int curStep;
  Function(int) onChange;
  Step3({Key key,this.curStep,this.onChange}): super(key: key);
  @override
  _Step3State createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  furnished _character;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
            child: Text('How many working guest will fit  into your space?',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'poppins_bold',fontSize: 15),),
          ),
          Container(margin: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    height: 35,
                    width: 50,
                    child: Icon(Icons.remove,color: Colors.white,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30)),
                        color: Pelette.ColorPrimaryDark
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 35,
                  color: Colors.white,
                  child: Text('1',textAlign: TextAlign.center,style: TextStyle(color: Colors.black),),
                ),
                GestureDetector(
                  child: Container(
                    height: 35,
                    width: 50,
                    child: Icon(Icons.add,color: Colors.white,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
                        color: Pelette.ColorPrimaryDark
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(margin: const EdgeInsets.only(top: 30),
            child: Text('Do you allow Visitors during the rent',style: TextStyle(fontSize: 15,fontFamily: 'poppins_semibold',color: Colors.black),),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: furnished.Yes,
                  groupValue: _character,
                  onChanged: (furnished value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                Text('Yes'),
                Radio(
                  value: furnished.No,
                  groupValue: _character,
                  onChanged: (furnished value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                Text('No'),
              ],
            ),
          ),
          Container(margin: const EdgeInsets.only(top: 10,left: 20,right: 20),
            height: 40,
            child: FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              minWidth: MediaQuery.of(context).size.width,
              color: Pelette.ColorPrimaryDark,
              onPressed: (){
                widget.onChange(widget.curStep);
                print(widget.curStep);
              },
              child: Text('Continue',style: TextStyle(color: Pelette.ColorWhite),),
            ),
          )
        ],
      ),
    );
  }
}
enum furnished { Yes, No }

