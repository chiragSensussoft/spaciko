import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spaciko/model/JsonModel.dart';
import 'package:spaciko/model/LatLong.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyDemo(),);
  }
}

class MyDemo extends StatefulWidget {
  @override
  _MyDemoState createState() => _MyDemoState();
}

class _MyDemoState extends State<MyDemo> {

  // Future<String> loadPersonAssets() async{
  //   return await rootBundle.loadString('json/latlng.json');
  // }

  // Future loadPerson() async{
  //   String jsonString = await loadPersonAssets();
  //   final jsonResponse = json.decode(jsonString);
  //   LatLong latLong = LatLong.fromJson(jsonResponse);
  //   print(latLong.list.map((e) => print(("${e.lat}<==>${e.lng}\n"))));
  //   return latLong.list;
  // }
  List<ParseLatlng> loadPerson() {
    String jsonString = '{"offices": [{"address": "Aabogade 158200 AarhusDenmark", "id": "aarhus", "image": "https://lh3.googleusercontent.com/tpBMFN5os8K-qXIHiAX5SZEmN5fCzIGrj9FdJtbZPUkC91ookSoY520NYn7fK5yqmh1L1m3F2SJA58v6Qps3JusdrxoFSwk6Ajv2K88", "lat": 56.172249, "lng": 10.187372, "name": "Aarhus", "phone": "", "region": "europe"}, {"address": "Claude Debussylaan 341082 MD, AmsterdamNetherlands", "id": "amsterdam", "image": "https://lh3.googleusercontent.com/gG1zKXcSmRyYWHwUn2Z0MITpdqwb52RAEp3uthG2J5Xl-4_Wz7_WmoM6T_TBg6Ut3L1eF-8XENO10sxVIFdQHilj8iRG29wROpSoug", "lat": 52.337801, "lng": 4.872066, "name": "Amsterdam", "phone": "", "region": "europe"}, {"address": "2300 Traverwood Dr.Ann Arbor, MI 48105United States", "id": "ann-arbor", "image": "https://lh3.googleusercontent.com/Iim0OVcAgg9vmXc5ADn9KvOQFplrMZ8hBTg2biiTtuWPy_r56cy4Byx1ROk6coGt7knQdmx_jO45VX1kiCJZ0QzEtS97AP_BYG4F2w", "lat": 42.3063848, "lng": -83.7140833, "name": "Ann Arbor", "phone": "+1 734-332-6500", "region": "north-america"}, {"address": "Fragkokklisias 7Athens 151 25Greece", "id": "athens", "image": "https://lh3.googleusercontent.com/XroZnqewSrO6KuvXM5hDHtjUJzUcRQLZYfCKs4jP44dKezRvNx58uxaqUKS4fQ2eXzG2TpJNJ1X2xtfBe7Prl5hSG_xjPEF1xLtFodM", "lat": 38.03902, "lng": 23.804595, "name": "Athens", "phone": "", "region": "europe"}, {"address": "10 10th Street NEAtlanta, GA 30309United States", "id": "atlanta", "image": "https://lh3.googleusercontent.com/py7Qvqqoec1MB0dMKnGWn7ju9wET_dIneTb24U-ri8XAsECJnOaBoNmvfa51PIaC0rlsyQvQXvAK8RdLqpkhpkRSzmhNKqb-tY2_", "lat": 33.781827, "lng": -84.387301, "name": "Atlanta", "phone": "+1 404-487-9000", "region": "north-america"}, {"address": "500 W 2nd StSuite 2900Austin, TX 78701United States", "id": "austin", "image": "https://lh3.googleusercontent.com/WFaJgWPdd7xPL7CQHizlqEzLDjT_GUAiWHIWUM0PiVSsv8q3Rjt9QgbyQazuQwYfN5qLORajv8eKSHlKwZo-M89T2Y12zFSxSIme08c", "lat": 30.266035, "lng": -97.749237, "name": "Austin", "phone": "+1 512-343-5283", "region": "north-america"}]}';
    final jsonResponse = json.decode(jsonString);
     LatLong latLong = LatLong.fromJson(jsonResponse);
    return latLong.list;
  }

@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ParseLatlng> list = loadPerson();
    return Scaffold(
      body: Container(
        child: Center(child: Text(list[0].id),),
      )
    );
  }
}