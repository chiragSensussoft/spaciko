import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/Home/Ui/Add/Model/SetHour.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';

class Step11 extends StatefulWidget {
  int curStep;
  Function(int) onChange;
  Step11({Key key,this.curStep,this.onChange}): super(key: key);
  @override
  _Step11State createState() => _Step11State();
}

class _Step11State extends State<Step11> {
  bool cb1 = false;

  List<String> dropdownValueList;
  String dropdownValue = 'Open';
  String dropdownValue1 = 'All Over';
  List<String> week =['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];

  int isSelected = -1;
  bool isSetHur = false;

  String openTime;
  String closeTime;
  String  _minute, _time,period;
  int _hour;

  TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 00,);

  List<SetHour> selectedItemValue = List<SetHour>();
  List<SetHour> selectedHours = List<SetHour>();
  List<SetTime> timeList = List<SetTime>();

  List<DropdownMenuItem<String>> _listMenu() {
    List<String> list = ["Open", "Close"];
    return list.map((value) => DropdownMenuItem(value: value, child: Text(value),)).toList();
  }

  List<DropdownMenuItem<String>> _listHours() {
    List<String> list = ["All Over", "Set Hours"];
    return list.map((value) => DropdownMenuItem(value: value, child: Text(value,style: TextStyle(fontSize: 14),),)).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(margin: const EdgeInsets.only(top: 15),
              child: Text('Set your space availability',style: TextStyle(color: Colors.black,
                fontFamily: 'poppins_semibold',
              ),),
            ),
            Container(
              child: _customCheckBox('Use sunday\'s opening hours for entire week',cb1,(val)=>setState(()=>cb1=!val)),
            ),
            Container(
              child: _availability(),
            ),
            Container(margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
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
  Widget _customCheckBox(String text,bool cb,Function onTap){
    return GestureDetector(
      child: Row(
        children: [
          Container(margin: const EdgeInsets.only(right: 2,left: 8,top: 15,bottom: 10),
            height: 20.0,
            width: 20.0,
            decoration:  BoxDecoration(
              color: cb
                  ? AppColors.colorPrimaryDark
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

  Widget _availability(){
    return ListView.builder(
      itemCount: week.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_,index){

        for (int i = 0; i < week.length; i++) {
          selectedItemValue.add(SetHour(title : "Open", selected: false));
          selectedHours.add(SetHour(title : "All Over", selected: false));
        }

        for (int i = 0; i < week.length; i++) {
          timeList.add(SetTime(openTime: 'Open Time',closeTime: 'Close Time'));

        }

        return Container(margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child:  Text(week[index],style: TextStyle(color: Colors.black,fontFamily: 'poppins_semibold',fontSize: 15),textAlign: TextAlign.center,),
                  ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(margin: const EdgeInsets.only(left: 5,right: 5),
                                height: 35,
                                child:  Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(26),
                                  child: Container(padding: const EdgeInsets.only(left: 10,right: 10),
                                    child: DropdownButton(
                                        isExpanded: true,
                                        value: selectedItemValue[index].title.toString(),
                                        underline: Container(height: 0,),
                                        icon: Icon(Icons.arrow_drop_down,color: Colors.black,size: 28,),
                                        onChanged: (String data) {
                                          selectedItemValue[index].title = data;
                                          selectedItemValue[index].title=='Close'? selectedItemValue[index].selected = true :selectedItemValue[index].selected = false;

                                          if(selectedItemValue[index].title=='Close' && selectedHours[index].title=='Set Hours'){
                                            selectedHours[index].title ="All Over";
                                            selectedHours[index].selected = !selectedHours[index].selected;
                                          }
                                          setState(() {});
                                        },
                                        items: _listMenu()
                                    ),
                                  ),
                                )
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(margin: const EdgeInsets.only(left: 5,right: 5),
                                height: 35,
                                child:  Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(26),
                                  child: Container(padding: const EdgeInsets.only(left: 10,right: 10),
                                      child: IgnorePointer(
                                        ignoring: selectedItemValue[index].selected,
                                        child: DropdownButton(
                                            isExpanded: true,
                                            value: selectedHours[index].title,
                                            underline: Container(height: 0,),
                                            icon: Icon(Icons.arrow_drop_down,color: Colors.black,size: 28,),
                                            onChanged: (String newValue) {
                                              selectedHours[index].title = newValue;
                                              selectedHours[index].title=='Set Hours'?selectedHours[index].selected=true:selectedHours[index].selected=false;
                                              setState(() {});
                                            },
                                            items:_listHours()
                                        ),
                                      )
                                  ),
                                )
                            ),
                          )
                        ],
                      ),
                      Visibility(
                        visible: selectedHours[index].selected,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    _selectTime(context,index,0);
                                    print(index);
                                  },
                                  child: Container(margin: const EdgeInsets.only(left: 5,right: 5,top: 10),
                                      height: 35,
                                      child:  Material(
                                        elevation: 4,
                                        borderRadius: BorderRadius.circular(26),
                                        child: Container(padding: const EdgeInsets.only(left: 10,right: 10),
                                          child: Center(child: Text(timeList[index].openTime,style: TextStyle(fontSize: 15),),),
                                        ),
                                      )
                                  ),
                                )
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  _selectTime(context,index,1);
                                  print(index);
                                },
                                child: Container(margin: const EdgeInsets.only(left: 5,right: 5,top: 10),
                                    height: 35,
                                    child:  Material(
                                      elevation: 4,
                                      borderRadius: BorderRadius.circular(26),
                                      child: Container(padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Center(child: Text(timeList[index].closeTime,style: TextStyle(fontSize: 15),),),
                                      ),
                                    )
                                ),
                              )
                            )
                          ],
                        ),
                      )
                    ],
                  )
                )
                ],
              ),
             Container(margin: const EdgeInsets.only(top: 10),
               child:  Divider(
                 height: 2,
                 color: Colors.black,
               ),
             ),

            ],
          )
        );
      },
    );
  }
  Future<Null> _selectTime(BuildContext context,int index,int id) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    String am_pm;
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour;
        _minute = selectedTime.minute.toString();
        _hour<12?am_pm='AM':am_pm='PM';
        _time = _hour.toString() + ' : ' + _minute + ' ' +am_pm;
        id==0?timeList[index].openTime = _time:timeList[index].closeTime = _time;
      });
  }
}
