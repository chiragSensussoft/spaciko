import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spaciko/utils/Validation.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';

class Step5 extends StatefulWidget {
  int curStep;
  Function(int) onChange;
  Step5({Key key,this.curStep,this.onChange}): super(key: key);

  @override
  _Step5State createState() => _Step5State();
}

class _Step5State extends State<Step5> {
  BitmapDescriptor pinLocationIcon;
  LatLng _lng;
  Position _currentPosition;
  Map<String,Marker> markers ={};
  Completer<GoogleMapController> _controller = Completer();
  final _formKey = GlobalKey<FormState>();

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _lng = LatLng(_currentPosition.latitude,_currentPosition.longitude);
      });
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
  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    _getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text('Please provide the full full physical address of your venue.',
                    textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontFamily: 'poppins_semibold',fontSize: 16)),
              ),
              Container(margin: const EdgeInsets.only(left: 10,right: 10,top: 20),
                alignment: Alignment.centerLeft,
                child: Text('My Listing Address',
                    style: TextStyle(color: Colors.black,fontFamily: 'poppins_semibold',fontSize: 15)),
              ),
              Container(
                height: 42,
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Stack(
                  children: [
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(25),
                      child: TextFormField(
                        validator: (text){
                          if(Validation.isNameEmpty(text)){
                            return 'Enter Listing Address';
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none),
                            contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0)),
                      ),
                    ),
                    Container(margin: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      child: Image(image: AssetImage('image/ic_pink_send.png'),),
                    )
                  ],
                )
              ),
              Container(margin: const EdgeInsets.only(top: 20,left: 10,),
                alignment: Alignment.centerLeft,
                child: Text('Comment',
                    style: TextStyle(color: Colors.black,fontFamily: 'poppins_semibold',fontSize: 15)),
              ),
              Container(margin: const EdgeInsets.only(left: 10,right: 10),
                height: 110,
                child:  Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(25),
                  child: TextFormField(
                    maxLines: 5,
                    validator: (text){
                      if(Validation.isNameEmpty(text)){
                        return 'Enter Listing Address';
                      }
                      else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0)),
                  ),
                ),
              ),
              Container(margin: const EdgeInsets.only(top: 20,left: 10,right: 10),
                height: 180,
                child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: LatLng(21.1702, 72.8311), zoom: 8),
                  markers: Set.of(markers.values),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    setState(() {
                      markers['1'] = Marker(
                          markerId: MarkerId('1'),
                          position: LatLng(21.1702, 72.8311),
                          icon: pinLocationIcon);
                    });
                  },
                ),
              ),
              Container(margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
                height: 40,
                child: FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  minWidth: MediaQuery.of(context).size.width,
                  color: AppColors.colorPrimaryDark,
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      widget.onChange(widget.curStep);
                    }else{
                      Toast _toast = Toast();
                      _toast.overLay = false;
                      _toast.showOverLay('Fill up First', Colors.white, Colors.black54, context);
                    }
                  },
                  child: Text('Continue',style: TextStyle(color: AppColors.colorWhite),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
