import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spaciko/model/CheckItem.dart';
import 'package:spaciko/model/LatLong.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';
import 'dart:ui' as ui;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CompassScreen(),
    );
  }
}


class CompassScreen extends StatefulWidget {
  @override
  _CompassScreenState createState() => _CompassScreenState();
}

var toast = Toast();
class _CompassScreenState extends State<CompassScreen> {
  bool visible = false;
  bool temp = true;
  List<String> blankBtnFilterList = [];
  List<String> buttonFilter = ['Hourly','Daily','Monthly','Property Type'];
  checkItem items;

  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor greenMarker;
  BitmapDescriptor markerIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  Position _currentPosition;
  List<String> buttonFilter1 = ['Hourly','Daily','Monthly','Property Type'];
  LatLng _lng;
  List<String> selectedMarker =[];

  List<ParseLatlng> loadPerson() {
    String jsonString = '{"offices": [{"address": "Aabogade 158200 AarhusDenmark", "id": "aarhus", "image": "https://lh3.googleusercontent.com/tpBMFN5os8K-qXIHiAX5SZEmN5fCzIGrj9FdJtbZPUkC91ookSoY520NYn7fK5yqmh1L1m3F2SJA58v6Qps3JusdrxoFSwk6Ajv2K88", "lat": 56.172249, "lng": 10.187372, "name": "Aarhus", "phone": "", "region": "europe"}, {"address": "Claude Debussylaan 341082 MD, AmsterdamNetherlands", "id": "amsterdam", "image": "https://lh3.googleusercontent.com/gG1zKXcSmRyYWHwUn2Z0MITpdqwb52RAEp3uthG2J5Xl-4_Wz7_WmoM6T_TBg6Ut3L1eF-8XENO10sxVIFdQHilj8iRG29wROpSoug", "lat": 52.337801, "lng": 4.872066, "name": "Amsterdam", "phone": "", "region": "europe"}, {"address": "2300 Traverwood Dr.Ann Arbor, MI 48105United States", "id": "ann-arbor", "image": "https://lh3.googleusercontent.com/Iim0OVcAgg9vmXc5ADn9KvOQFplrMZ8hBTg2biiTtuWPy_r56cy4Byx1ROk6coGt7knQdmx_jO45VX1kiCJZ0QzEtS97AP_BYG4F2w", "lat": 42.3063848, "lng": -83.7140833, "name": "Ann Arbor", "phone": "+1 734-332-6500", "region": "north-america"}, {"address": "Fragkokklisias 7Athens 151 25Greece", "id": "athens", "image": "https://lh3.googleusercontent.com/XroZnqewSrO6KuvXM5hDHtjUJzUcRQLZYfCKs4jP44dKezRvNx58uxaqUKS4fQ2eXzG2TpJNJ1X2xtfBe7Prl5hSG_xjPEF1xLtFodM", "lat": 38.03902, "lng": 23.804595, "name": "Athens", "phone": "", "region": "europe"}, {"address": "10 10th Street NEAtlanta, GA 30309United States", "id": "atlanta", "image": "https://lh3.googleusercontent.com/py7Qvqqoec1MB0dMKnGWn7ju9wET_dIneTb24U-ri8XAsECJnOaBoNmvfa51PIaC0rlsyQvQXvAK8RdLqpkhpkRSzmhNKqb-tY2_", "lat": 33.781827, "lng": -84.387301, "name": "Atlanta", "phone": "+1 404-487-9000", "region": "north-america"}, {"address": "500 W 2nd StSuite 2900Austin, TX 78701United States", "id": "austin", "image": "https://lh3.googleusercontent.com/WFaJgWPdd7xPL7CQHizlqEzLDjT_GUAiWHIWUM0PiVSsv8q3Rjt9QgbyQazuQwYfN5qLORajv8eKSHlKwZo-M89T2Y12zFSxSIme08c", "lat": 30.266035, "lng": -97.749237, "name": "Austin", "phone": "+1 512-343-5283", "region": "north-america"}]}';
    final jsonResponse = json.decode(jsonString);
    LatLong latLong = LatLong.fromJson(jsonResponse);
    return latLong.list;
  }

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    setGreenCustomMapPin();
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
      // GoogleMap(
      //   initialCameraPosition: CameraPosition(target: _lng,zoom: 8),
      //   markers: _markers,
      //   onMapCreated: (GoogleMapController controller){
      //     _controller.complete(controller);
      //     setState(() {
      //       _markers.add(Marker(markerId: MarkerId('<MARKER_ID>'),icon: pinLocationIcon,position:_lng));
      //     });
      //   },
      // );
    }).catchError((e) {
      print(e);
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

  void setCustomMapPin() async {
    pinLocationIcon = await getBitmapDescriptorFromAssetBytes('image/ic_marker1.png', 40);
  }
  void setGreenCustomMapPin() async {
    greenMarker = await getBitmapDescriptorFromAssetBytes('image/ic_pin_circle_green.png', 40);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            initialCameraPosition: CameraPosition(target: LatLng(56.172249,10.187372),zoom: 4),
            markers: _markers,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
              setState(() {
                List<ParseLatlng> list = loadPerson();
                print(list.length);
                for(int i=0;i<list.length;i++){
                  _markers.add(Marker(markerId: MarkerId(list[i].id),icon:temp?greenMarker:pinLocationIcon,position:LatLng(list[i].lat,list[i].lng),
                    onTap: (){
                          temp = false;
                          print('Marker Color =>>$temp');
                    }
                  ));
                }
              });
            },
          ) :Center(child: CircularProgressIndicator(),),

                Visibility(
                  child: Container(
                    height: 228,
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
