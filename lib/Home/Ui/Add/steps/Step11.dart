import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/Home/Ui/Add/Model/SetHour.dart';
import 'package:spaciko/widgets/Pelette.dart';

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
  List<String> ddl =['Open','Close'];
  List<String> time =['All Over','Set Hours'];

  int isSelected = -1;
  bool isSetHour = false;

  List<SetHour> selectedItemValue = List<SetHour>();
  List<SetHour> selectedHours = List<SetHour>();

  List<DropdownMenuItem<String>> _listMenu(){
    List<String> list =['Open','Close'];
    return list.map((e) => DropdownMenuItem(value: e,child: Text(e),)).toList();
  }
  List<DropdownMenuItem<String>> _listHours(){
    st<String> list =['All Over','Set Hours'];
    return list.map((e) => DropdownMenuItem(value: e,child: Text(e),)).toList();
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

  Widget _availability(){
    return ListView.builder(
      itemCount: week.length,
      shrinkWrap: true,
      itemBuilder: (_,index){
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
                    flex: 2,
                    child: Container(margin: const EdgeInsets.only(left: 5,right: 5),
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
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValueList.add(newValue);
                                  print(dropdownValueList);
                                });
                              },
                              items: ddl
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(fontSize: 15)),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child:  Container(margin: const EdgeInsets.only(left: 5,right: 5),
                        height: 35,
                        child:  Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(26),
                          child: Container(padding: const EdgeInsets.only(left: 10,right: 10),
                            child: DropdownButton(
                              isExpanded: true,
                              value: dropdownValue1,
                              underline: Container(height: 0,),
                              icon: Icon(Icons.arrow_drop_down,color: Colors.black,size: 28,),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue1 = newValue;
                                });
                              },
                              items: time
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(fontSize: 15),),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                    ),
                  ),
                ],
              ),
             Container(margin: const EdgeInsets.only(top: 10),
               child:  Divider(
                 height: 2,
                 color: Colors.black,
               ),
             )
            ],
          )
        );
      },
    );
  }

}
