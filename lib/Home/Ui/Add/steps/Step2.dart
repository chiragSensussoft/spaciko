import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Step2 extends StatefulWidget {
  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  SingingCharacter _character;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('is your space fully furnished?',style: TextStyle(fontFamily: 'poppins_medium',fontSize: 15),),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                     value: SingingCharacter.Yes,
                     groupValue: _character,
                     onChanged: (SingingCharacter value) {
                       setState(() {
                         _character = value;
                       });
                     },
                   ),
               Text('Yes'),
               Radio(
                     value: SingingCharacter.No,
                     groupValue: _character,
                     onChanged: (SingingCharacter value) {
                       setState(() {
                         _character = value;
                       });
                     },
                   ),
                Text('No'),
              ],
            ),
          ),
          Container(
            child: Text('How Many RoomS do You Offer?',style: TextStyle(fontSize: 15,fontFamily: 'poppins_medium'),),
          ),
          Container(margin: const EdgeInsets.only(top: 10,left: 0,right: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25)
            ),
            child: TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0)
              ),
            ),
          ),
          Container(padding: const EdgeInsets.only(left: 20,right: 20),
            child: Text('Are your Working Station/dask shared or private?',style: TextStyle(fontSize: 18,fontFamily: 'poppins_medium'),textAlign: TextAlign.center,),
          )
        ],
      )
    );
  }
}
enum SingingCharacter { Yes, No }