import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:table_calendar/table_calendar.dart';

class Publish extends StatefulWidget {
  @override
  _PublishState createState() => _PublishState();
}

class _PublishState extends State<Publish> {
  String dropdownValue = 'Select';
  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
           Container(margin: const EdgeInsets.only(left: 50,right: 50),
             child:  Text('Show Work Travellers When They Can Book',style:
             TextStyle(color: Colors.black,fontSize: 15,fontFamily:'poppins_semibold'),textAlign: TextAlign.center,),
           ),
            Container(margin: const EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              child: Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: 35,
                  child:  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(26),
                    child: Container(padding: const EdgeInsets.only(left: 10,right: 10),
                      child: DropdownButton(
                        isExpanded: true,
                        value: dropdownValue,
                        underline: Container(height: 0,),
                        icon: Icon(Icons.arrow_drop_down,color: Colors.black,size: 28,),
                        onChanged: (String data) {
                          setState(() {
                            dropdownValue = data;
                          });
                        },
                        items: <String>['Select', 'Two', 'Tree', 'Four']
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
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TableCalendar(
                  initialCalendarFormat: CalendarFormat.month,
                  calendarStyle: CalendarStyle(
                      todayColor: Colors.blue,
                      selectedColor: Theme.of(context).primaryColor,
                      todayStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          color: Colors.white)
                  ),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    formatButtonTextStyle: TextStyle(color: Colors.white),
                    formatButtonShowsNext: false,
                  ),

                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.colorPink,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                    todayDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  calendarController: _controller,
                )
              ],
            ),
            Container(margin: const EdgeInsets.only(top: 30,left: 10,right: 10),
              height: 40,
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                minWidth: MediaQuery.of(context).size.width,
                color: AppColors.colorPink,
                onPressed: (){
                },
                child: Text('Continue',style: TextStyle(color: AppColors.colorWhite),),
              ),
            ),
          ],
        )
      ),
    );
  }
}