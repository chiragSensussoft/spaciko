import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spaciko/model/CheckItem.dart';
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

  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  Position _currentPosition;
  LatLng _lng;

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    _getCurrentLocation();
  }

  void itemChange(bool val, int index){
    setState(() {
      checkList[index].isChecked = val;
    });
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print("${_currentPosition.latitude}${_currentPosition.longitude}");
        _lng = LatLng(_currentPosition.latitude,_currentPosition.longitude);
      });
      GoogleMap(
        initialCameraPosition: CameraPosition(target: _lng,zoom: 8),
        markers: _markers,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
          setState(() {
            _markers.add(Marker(markerId: MarkerId('<MARKER_ID>'),icon: pinLocationIcon,position:_lng));
          });
        },
      );
    }).catchError((e) {
      print(e);
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(),
        'image/ic_marker1.png');
  }

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
                          height: 60,
                          child: Stack(
                            children: [
                              Container(
                                child: Card(
                                  elevation: 0.5,
                                  child: TextFormField(
                                    cursorColor: Pelette.ColorPrimaryDark,
                                    decoration: InputDecoration(
                                      prefixIcon: Container(margin: const EdgeInsets.only(left: 10),
                                        child: Image(image: AssetImage('image/ic_search_grey_25.png'),height: 30,width: 30,),),
                                        hintText: 'Address,City,Zip,Neighbourhood',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.zero,borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                              ),
                              Container(margin: const  EdgeInsets.only(right: 20),
                                alignment: Alignment.centerRight,
                                child: Image(image: AssetImage('image/ic_green_send.png'),height: 30,width: 30,),
                              )
                            ],
                          )
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
                (_lng!=null)?GoogleMap(
            initialCameraPosition: CameraPosition(target: _lng,zoom: 8),
            markers: _markers,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
              setState(() {
                _markers.add(Marker(markerId: MarkerId('<MARKER_ID>'),icon: pinLocationIcon,position:_lng));
              });
            },
          )
                :Center(child: CircularProgressIndicator(),),

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
                              return  GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      checkList[index].isChecked = !checkList[index].isChecked;
                                    });
                                  },
                                  child: Container(margin: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        checkList[index].isChecked
                                            ? Icon(
                                          Icons.check_circle,
                                          color: Pelette.ColorPrimaryDark,
                                          size: 25,
                                        )
                                            : Icon(
                                          Icons.circle,
                                          color: Colors.grey[100],
                                          size: 25,
                                        ),
                                        SizedBox(width: 5),
                                        Text(checkList[index].item),
                                      ],
                                    ),
                                  )
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
                                     checkList.map((e) => e.isChecked=true).toList();
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
                                      blankBtnFilterList.remove('3');
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