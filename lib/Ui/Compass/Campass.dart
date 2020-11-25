import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
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


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: Container(
              child: Column(
                  children: <Widget>[
                    Container(padding: const EdgeInsets.fromLTRB(5, 0, 5,0),
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
      body: Stack(
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
    );
    }
}