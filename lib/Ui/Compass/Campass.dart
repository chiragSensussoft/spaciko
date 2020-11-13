import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CompassScreen extends StatefulWidget {
  @override
  _CompassScreenState createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.1702, 72.8311),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: PreferredSize(
  //       preferredSize: Size.fromHeight(50),
  //       child: Container(padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
  //         child: Material(
  //           elevation: 1,
  //             child: TextField(
  //               decoration: InputDecoration(
  //                   hintText: 'Search View',
  //                   border: OutlineInputBorder(borderRadius: BorderRadius.zero,borderSide: BorderSide.none)
  //               ),
  //             ),
  //         ),
  //       )
  //     ),
  //     body: Container(
  //       child: Center(
  //           child: Text('Compass')
  //       ),
  //     ),
  //   );
  // }
}

