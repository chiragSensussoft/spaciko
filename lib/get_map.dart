import 'package:flutter/material.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

final List<String> entries = <String>['A','B','C','D'];
final List<int> colorCodes = <int>[600,500,400,300];
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) => Scaffold(
   body: ListView.builder(
     scrollDirection: Axis.horizontal,
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
            Container(margin: const EdgeInsets.only(left: 2,right: 2),
            height: 50,
            width: MediaQuery.of(context).size.width/4,
            color: Colors.amber[colorCodes[index]],
            child: Center(child: Text('Entry ${entries[index]}')),
          )
            ],
          );
        }
    ),
  );
}
