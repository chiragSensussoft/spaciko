import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  double _width;

  List<IconData> _icons = [
    Icons.home,
    Icons.add,
    Icons.message,
    Icons.home,
    Icons.home
  ];

  int _curStep;
  Color _activeColor;
  Color _inactiveColor = Colors.grey[100];
  double lineWidth = 4.0;

  Comment(
      {Key key,
      @required List<IconData> icons,
      @required int curStep,
      List<String> titles,
      @required double width,
      @required Color color})
      :
        _icons = icons,

        _curStep = curStep,
        _width = width,
        _activeColor = color,
        // assert(curStep > 0 == true && curStep <= icons.length),
        // assert(width > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: 32.0,
          left: 24.0,
          right: 24.0,
        ),
        width: this._width,
        child: Column(
          children: <Widget>[
            Row(
              children: _iconViews(),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        )
    );
  }

  List<Widget> _iconViews() {
    var list = <Widget>[];

    _icons.asMap().forEach((i, icon) {
      //colors according to state
      var circleColor =
          (i == 0 || _curStep > i + 1) ? _activeColor : _inactiveColor;

      var lineColor = _curStep > i + 1 ? _activeColor : _inactiveColor;

      var iconColor =
          (i == 0 || _curStep > i + 1) ? _inactiveColor : _activeColor;

      list.add(
        //dot with icon view
        Container(
          width: 30.0,
          height: 30.0,
          padding: EdgeInsets.all(0),
          child: Icon(
            icon,
            color: iconColor,
            size: 15.0,
          ),
          decoration: new BoxDecoration(
            color: circleColor,
            borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
            border: new Border.all(
              color: _activeColor,
              width: 2.0,
            ),
          ),
        ),
      );

      //line between icons
      if (i != _icons.length - 1) {
        list.add(Expanded(
            child: Container(
          height: lineWidth,
          color: lineColor,
        )));
      }
    }
    );

    return list;
  }

// class CommentNav extends StatefulWidget {
//   @override
//   _CommentNavState createState() => _CommentNavState();
// }
//
// class _CommentNavState extends State<CommentNav> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//
//       home: Scaffold(
//         body: Center(
//           child: Text('Comment', style: TextStyle(fontSize: 18, color: Colors.black),),
//         ),
//       ),
//     );
//   }
// }
}
