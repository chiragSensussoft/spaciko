import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AccountPage(),
    );
  }
}

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => new _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
   double _height;
   double _width;
   BoxDecoration decoration;
   List<String> _stepsText = ['1',',2','3','4','5','6'];
   int _curStep;
   Color _activeColor = Colors.yellow;
   Color _inactiveColor = Colors.cyanAccent;
   double _dotRadius =  30;
   EdgeInsets padding;
   double lineHeight;
   TextStyle _headerStyle;
   TextStyle _stepStyle = TextStyle(color: Colors.black);
   List<Widget> _buildDots() {

    var wids = <Widget>[];
    _stepsText.asMap().forEach((i, text) {
      var circleColor = (i == 0 || _curStep > i + 1)
          ? _activeColor
          : _inactiveColor;

      var lineColor = _curStep > i + 1
          ? _activeColor
          : _inactiveColor;

      wids.add(CircleAvatar(
        radius: _dotRadius,
        backgroundColor: circleColor,
      ));

      //add a line separator
      //0-------0--------0
      if (i != _stepsText.length - 1) {
        wids.add(
            Expanded(
                child: Container(height: lineHeight, color: lineColor,)
            )
        );
      }
    });

    return wids;
  }

   List<Widget> _buildText() {
     var wids = <Widget>[];
     _stepsText.asMap().forEach((i, text) {

       wids.add(Text(text, style: _stepStyle));
     });

     return wids;
   }
   @override
   Widget build(BuildContext context) {
     return Container(
         padding: padding,
         height: this._height,
         width: this._width,
         decoration: this.decoration,
         child: Column(
           children: <Widget>[
             Container(
                 child: Center(
                     child: RichText(
                         text: TextSpan(
                             children: [
                               TextSpan(
                                 text: (_curStep).toString(),
                                 style: _headerStyle.copyWith(
                                   color: _activeColor,//this is always going to be active
                                 ),
                               ),
                               TextSpan(
                                 text: " / " + _stepsText.length.toString(),
                                 style: _headerStyle.copyWith(
                                   color: _curStep == _stepsText.length
                                       ? _activeColor
                                       : _inactiveColor,
                                 ),
                               ),
                             ]
                         )
                     )
                 )
             ),
             Row(
               children: _buildDots(),
             ),
             SizedBox(height: 10,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: _buildText(),
             )
           ],
         ));
   }
}