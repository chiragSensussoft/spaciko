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



  bool val = true;
  final List<String> entries = <String>['A', 'B', 'C','D'];
  final List<int> colorCodes = <int>[600,400, 500, 100];
  List<String> _list =List();
  @override
  Widget build(BuildContext context) {
    var clr1 = Colors.black;
    var clr2 = Colors.amber;
    var clr3 = Colors.blue;
    var clr4 = Colors.cyanAccent;
    var screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: Container(
              child: Column(
                  children: <Widget>[
                    Container(margin: const EdgeInsets.fromLTRB(5, 5, 5,0),
                      height: 50,
                      child: Material(
                        elevation: 2,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Search View',
                              border: OutlineInputBorder(borderRadius: BorderRadius.zero,borderSide: BorderSide.none)
                          ),
                        ),
                      ),
                    ),
                        Container(
                          padding: EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Wrap(
                              children: _buildChoiceList(_selectedTextList),
                            ),
                          ),
                        ),
                  ],
                ),
          ),
      ),

      body: Container(
        height: 50,
          child:ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width/4,
                color: val?clr1:Colors.cyanAccent,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      val= false;
                    });

                  },
                ),
                margin: const EdgeInsets.only(right: 4),
              ),
              Container(
                width: MediaQuery.of(context).size.width/4,
                color: clr2??Colors.black,
                margin: const EdgeInsets.only(right: 4),
                child: GestureDetector(
                  onTap: (){
                    setState(() {

                    });
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width/4,
                color: clr3,
                margin: const EdgeInsets.only(right: 4),
                child: GestureDetector(
                  onTap: (){
                    setState(() {

                    });
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width/4,
                color: clr4,
                margin: const EdgeInsets.only(right: 4),
                child: GestureDetector(
                  onTap: (){
                    setState(() {

                    });
                  },
                ),
              ),
            ],
          ),


    // Stack(
    //     children: <Widget>[
    //       GoogleMap(
    //           markers: {
    //             Marker(
    //               GeoCoord(21.1702, 72.8311),
    //             )
    //           },
    //           initialZoom: 12,
    //           initialPosition:
    //           GeoCoord(21.1702, 72.8311),
    //           mapType: MapType.roadmap,
    //           interactive: true,
    //           onTap: (coord) {}
    //       ),
    //     ],
    //   ),
      )
    );
    }
}