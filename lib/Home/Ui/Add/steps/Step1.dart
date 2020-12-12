import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';

class Step1 extends StatefulWidget {
   int curStep;
   Function(int) onChange;
   Step1({Key key,this.curStep,this.onChange}): super(key: key);

  @override
  _Step1State createState() => _Step1State();
}

String dropdownValue = 'Select';
class _Step1State extends State<Step1> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
              child:  Text.rich(
                TextSpan(text: 'Ready to Place your space in the spotlight?',style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'poppins_semibold')),
                textAlign: TextAlign.center,
              ),
            ),
            Container(padding: const EdgeInsets.only(left: 5,right: 5,top: 10),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'With'),
                    TextSpan(text: ' Spaciko',style: TextStyle(color: AppColors.colorPrimaryDark)),
                    TextSpan(text: ' each working space deserve a spacial care. following these steps will allow you to highlight each working space as a separate listing'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(padding: const EdgeInsets.only(top: 30),
              child: Text('What Type of space do you own?',style:TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'poppins_semibold'),),
            ),
            Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
                width: MediaQuery.of(context).size.width,
                height: 40,
                child:  Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(26),
                  child: Container(padding: const EdgeInsets.only(left: 20,right: 20),
                    child: DropdownButton(
                      isExpanded: true,
                      value: dropdownValue,
                      underline: Container(height: 0,),
                      icon: Icon(Icons.arrow_drop_down,color: Colors.black,size: 28,),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['Select', 'Two', 'Free', 'Four']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                )
            ),
            Container(margin: const EdgeInsets.only(top: 50,left: 20,right: 20),
              height: 40,
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                minWidth: MediaQuery.of(context).size.width,
                color: AppColors.colorPrimaryDark,
                onPressed: (){
                  if(dropdownValue == 'Select'){
                    Toast _toast = Toast();
                    _toast.overLay = false;
                    _toast.showOverLay('Please Select a type', Colors.white, Colors.black54, context);
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
}
