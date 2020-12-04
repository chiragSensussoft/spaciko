import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:vertical_calendar/vertical_calendar.dart';

class CalenderScreen extends StatefulWidget {
  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}
String dropdownValue = 'Good';
class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Pelette.ColorPrimaryDark,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height *0.10,
              color: Pelette.ColorPrimaryDark,
              child: Center(
                child: Container(
                  width: 150,
                  height: 50,
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
                      }).toList(),
                    ),
                  )
                )
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                 // borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25)),

                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

