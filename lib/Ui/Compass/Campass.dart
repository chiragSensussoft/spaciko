import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:spaciko/Filter/buttonFilter.dart';
import 'package:spaciko/choice_chip_widget.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';


class CompassScreen extends StatefulWidget {
  @override
  _CompassScreenState createState() => _CompassScreenState();
}

var toast = Toast();
class _CompassScreenState extends State<CompassScreen> {
  List<String> butonsText = List();
  List<String> buttonItem = ['Hourly','Daily','Monthly','Property Type'];

  List<String> _selectedTextList = List();

  List<String> allTextList1;
  List<Widget> _objectList = <Widget>[
    new Text('test'),
    new Text('test')
  ];


  @override
  void initState() {
    _selectedTextList = buttonItem != null
        ? List.from(buttonItem)
        : [];

    super.initState();
  }
  List<Widget> _buildChoiceList(List<String> list) {
    List<Widget> choices = List();
    list.forEach(
          (item) {
        var selectedText = butonsText.contains(item);
        choices.add(
          ChoicechipWidget(
            onSelected: (value) {
              setState(
                    () {
                  selectedText
                      ? butonsText.remove(item)
                      : butonsText.add(item);
                },
              );
            },
            selected: selectedText,
            selectedTextColor: Pelette.ColorWhite,
            selectedTextBackgroundColor: Pelette.ColorPrimaryDark,
            unselectedTextBackgroundColor: Pelette.ColorWhite,
            unselectedTextColor: Pelette.ColorPrimaryDark,
            text: item,
          ),
        );
      },
    );
    return choices;
  }
  void _addOne() {
    setState(() {
      _objectList = List.from(_objectList)
        ..add(Text("foo"));
    });
  }

  void _removeOne() {
    setState(() {
      _objectList = List.from(_objectList)..removeLast();
    });
  }

  List<String> propList = [];
  int select=-1;
  List<String> numbers = ['Hourly','Daily','Monthly','Property Type'];
  @override
  Widget build(BuildContext context) {


    var screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
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
                  height: 40,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: numbers.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            print(index);
                            setState((){
                            });

                            if(propList.contains(index.toString())){
                              propList.remove(index.toString());
                              print(propList.toString());
                            }
                            else{
                              propList.add(index.toString());
                              print(propList.toString());
                            }
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
                                color: propList.contains(index.toString())?Color(0xff18a499):Colors.white,
                              ),
                              child: Container(
                                child: Center(child: Text(numbers[index], style: TextStyle(color: propList.contains(index.toString())?Colors.white:Color(0xff18a499), fontSize: 13.0),)),
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
              ],
            ),
            )
    );
    }
}