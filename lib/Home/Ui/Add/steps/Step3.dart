import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';

class Step3 extends StatefulWidget {
  int curStep;
  Function(int) onChange;
  Step3({Key key,this.curStep,this.onChange}): super(key: key);
  @override
  _Step3State createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  int isAllowVisitor = -1;
  int guest =0;

  @override
  void initState() {
    super.initState();
  }

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
                        color: AppColors.colorPrimaryDark
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      if(guest>0){
                        guest -= 1;
                      }
                    });
                  },
                ),
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 35,
                  color: Colors.white,
                  child: Text(guest.toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.black),),
                ),
                GestureDetector(
                  child: Container(
                    height: 35,
                    width: 50,
                    child: Icon(Icons.add,color: Colors.white,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
                        color: AppColors.colorPrimaryDark
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      guest += 1;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(margin: const EdgeInsets.only(top: 30),
            child: Text('Do you allow Visitors during the rent',style: TextStyle(fontSize: 15,fontFamily: 'poppins_semibold',color: Colors.black),),
          ),
          Container(
            margin:  EdgeInsets.all(10.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _customRadio(1, 'Yes',(val)=>setState(()=>isAllowVisitor= val)),
                _customRadio(0, 'No',(val)=>setState(()=>isAllowVisitor= val)),
              ],
            ),
          ),
          Container(margin: const EdgeInsets.only(top: 10,left: 20,right: 20),
            height: 40,
            child: FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              minWidth: MediaQuery.of(context).size.width,
              color: AppColors.colorPrimaryDark,
              onPressed: (){
                if(isAllowVisitor==-1||guest==0){
                  Toast _toast = Toast();
                  _toast.overLay = false;
                  _toast.showOverLay('Fill up First', Colors.white, Colors.black54, context);
                }else{
                  widget.onChange(widget.curStep);
                }
              },
              child: Text('Continue',style: TextStyle(color: AppColors.colorWhite),),
            ),
          )
        ],
      ),
    );
  }

  Widget _customRadio(int val,String text,Function onTap){
    return GestureDetector(
      child: Row(
        children: [
          Container(margin: const EdgeInsets.only(right: 2,left: 8),
            height: 20.0,
            width: 20.0,
            decoration:  BoxDecoration(
              color: val == isAllowVisitor
                  ? AppColors.colorPrimaryDark
                  : Colors.white,
              borderRadius: const BorderRadius.all(const Radius.circular(30)),
            ),
          ),
          Text(text),
        ],
      ),
      onTap: () {
        setState(() {
          if(text=='Yes'){
            onTap(1);
          }
          else{
            onTap(0);
          }
        });
      },
    );
  }
}

