import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:spaciko/Filter/buttonFilter.dart';
import 'package:spaciko/widgets/Pelette.dart';

class CompassScreen extends StatefulWidget {
  @override
  _CompassScreenState createState() => _CompassScreenState();
}
final List<String> buttonItem = ['Hourly','Daily','Monthly','Property Type'];
var buttonFilter =   ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: buttonItem.length,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: [
          Container(margin: const EdgeInsets.all(1),
            height: 50,
            width: MediaQuery.of(context).size.width/4.03,
            decoration: BoxDecoration(
                color: Pelette.ColorPrimaryDark,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text(buttonItem[index])),
          ),
        ],
      );
    }
);
class _CompassScreenState extends State<CompassScreen> {

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            child: ButtonFilter()
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

            ),
          ],
        ),
      );
  }
}

