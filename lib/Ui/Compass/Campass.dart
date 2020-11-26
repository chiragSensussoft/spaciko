import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:spaciko/widgets/Toast.dart';


class CompassScreen extends StatefulWidget {
  @override
  _CompassScreenState createState() => _CompassScreenState();
}

var toast = Toast();
class _CompassScreenState extends State<CompassScreen> {
  List<String> butonsText = List();
  List<String> buttonItem = ['Hourly','Daily','Monthly','Property Type'];

  List<String> propList = [];
  List<String> numbers = ['Hourly','Daily','Monthly','Property Type'];
  @override
  Widget build(BuildContext context) {
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
                            setState((){
                              if(propList.contains(index.toString())){
                                propList.remove(index.toString());
                              }
                              else{
                                propList.add(index.toString());
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