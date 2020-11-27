import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';

class CompassScreen extends StatefulWidget {
  @override
  _CompassScreenState createState() => _CompassScreenState();
}

var toast = Toast();
class _CompassScreenState extends State<CompassScreen> {

  bool visible = false;
  List<String> blankBtnFilterList = [];
  List<String> buttonFilter = ['Hourly','Daily','Monthly','Property Type'];
  checkItem items;

  void itemChange(bool val, int index){
    setState(() {
      checkList[index].isChecked = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(

              child: Column(
                  children: <Widget>[
                    Container(margin: const EdgeInsets.fromLTRB(7, 5, 7,0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.1,
                            color: Colors.black12
                          )
                      ),
                      height: 50,
                      child: Material(
                        elevation: 1,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Search View',
                              border: OutlineInputBorder(borderRadius: BorderRadius.zero,borderSide: BorderSide.none)
                          ),
                        ),
                      ),
                    ),
                Container( margin: const EdgeInsets.only(top: 8,left: 4,right: 4),
                  height: 30,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: buttonFilter.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            setState((){
                              blankBtnFilterList.contains(index.toString())?blankBtnFilterList.remove(index.toString()):blankBtnFilterList.add(index.toString());
                              if(index==3)visible=visible?false:true;
                              if(index!=3){
                                visible=false;
                                blankBtnFilterList.remove('3');
                              }
                            });
                          },

                          child: Container(margin: const EdgeInsets.only(right: 4,left: 4),
                            width: MediaQuery.of(context).size.width /4,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff18a499),
                                    width: 0.8
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: blankBtnFilterList.contains(index.toString())?Color(0xff18a499):Colors.white,
                              ),
                              child: Container(
                                child: Center(child: Text(buttonFilter[index], style: TextStyle(color: blankBtnFilterList.contains(index.toString())?Colors.white:Color(0xff18a499), fontSize: 13.0),)),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ]
            ),
          ),
      ),
      body: Container(
         child:
          Stack(
              children: <Widget>[
                GoogleMap(
                    markers: {
                      Marker(
                        GeoCoord(21.1702, 72.8311),
                      )
                    },
                    initialZoom: 12,
                    initialPosition:
                    GeoCoord(21.1702, 72.8311),
                    mapType: MapType.roadmap,
                    interactive: true,
                    onTap: (coord) {}
                ),
                Visibility(
                  child: Container(
                    height: 226,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(margin: const EdgeInsets.only(left: 10),
                          child: Text('Property Type(${checkList.where((element) => element.isChecked).toList().length} Selected)',style: TextStyle(color: Colors.black,fontSize: 17,fontFamily: 'poppins_medium'),),
                        ),
                        Container(
                          height:150,
                          child: GridView.count(
                            childAspectRatio: 4/1,
                            crossAxisCount: 2,
                            children: List.generate(checkList.length, (index) {
                              return GestureDetector(
                                child: Container(
                                    child:
                                    CheckboxListTile(
                                      value: checkList[index].isChecked,
                                      title: Text(checkList[index].item,style: TextStyle(fontSize: 17),),
                                      controlAffinity: ListTileControlAffinity.leading,
                                      onChanged: (val){
                                        itemChange(val, index);
                                      },
                                    )
                                ),
                              );
                            }),
                          ),
                          ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          color: Pelette.ColorPrimaryDark,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Container(margin: const EdgeInsets.only(left: 5),
                               child:  InkWell(
                                 child:
                                 Text('Reset',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
                                 onTap: (){
                                   setState(() {
                                     // for(int i=0;i<checkList.length;i++){
                                     //   checkList[i].isChecked=false;
                                     // }
                                     checkList;
                                   });
                                 },
                               ),
                             ),
                              Container(margin: const EdgeInsets.only(right: 5),
                                child: FlatButton(
                                  color: Colors.white,
                                  child: Text('Done',style: TextStyle(color:Pelette.ColorPrimaryDark,fontSize: 17),),
                                  onPressed: (){
                                    setState(() {
                                      visible = false;
                                    });
                                  }
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                  visible: visible,
                ),
              ],
            ),
            )
    );
    }
}

 List<checkItem> checkList = <checkItem>[
   checkItem('Meeting Room'),
   checkItem('Open Space'),
   checkItem('Private Desk Area'),
   checkItem('Private Room'),
   checkItem('Shared Desk Area'),
   checkItem('Shared Room'),
];

class checkItem{
  bool isChecked = false;
  String item;
  checkItem(this.item);
}