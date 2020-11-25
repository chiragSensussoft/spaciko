import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> _objectList = <Widget>[
    new Text('test'),
    new Text('test')
  ];

  void _addOne() {
    setState(() {
      _objectList.add(new Text('test'));
    });
  }

  void _removeOne() {
    setState(() {
      _objectList.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:Container(
            child:Column(
              children: <Widget>[
                new ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: _objectList
                ),
                new Row(
                  children: [
                    new IconButton(
                      icon: new Icon(Icons.remove_circle),
                      iconSize: 36.0,
                      tooltip: 'Remove',
                      onPressed: _objectList.length > 2 ? _removeOne : null,
                    ),
                    new IconButton(
                      icon: new Icon(Icons.add_circle),
                      iconSize: 36.0,
                      tooltip: 'Add',
                      onPressed: _addOne,
                    )
                  ],
                ),
                new Text(_objectList.length.toString())
              ],
            )
        )
    );
  }
}