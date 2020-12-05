import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';

class Step1 extends StatefulWidget {
  @override
  _Step1State createState() => _Step1State();
}

String dropdownValue = 'Good';
class _Step1State extends State<Step1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
          child:  Text.rich(
            TextSpan(text: 'Ready to Place your space in the spotlight?',style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'poppins_bold')),
            textAlign: TextAlign.center,
          ),
        ),
        Container(padding: const EdgeInsets.only(left: 5,right: 5,top: 10),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'With'),
                TextSpan(text: ' Spaciko',style: TextStyle(color: Pelette.ColorPrimaryDark)),
                TextSpan(text: ' each working space deserve a spacial care. following these steps will allow you to highlight each working space as a separate listing'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(padding: const EdgeInsets.only(top: 30),
          child: Text('What Type of space do you own?',style:TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'poppins_bold'),),
        ),
        Container(margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
                color: Pelette.ColorWhite,
                borderRadius: BorderRadius.circular(26)
            ),
            child:  Center(
              child: DropdownButton(
                value: dropdownValue,
                underline: Container(height: 0,),
                icon: Icon(Icons.arrow_drop_down,color: Colors.black,size: 28,),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['Good', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),//fghn
              ),
            )
        ),
        Container(margin: const EdgeInsets.only(top: 140,left: 20,right: 20),
          height: 40,
          child: FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            minWidth: MediaQuery.of(context).size.width,
            color: Pelette.ColorPrimaryDark,
            onPressed: (){},
            child: Text('Continue',style: TextStyle(color: Pelette.ColorWhite),),
          ),
        )
      ],
    );
  }
}
