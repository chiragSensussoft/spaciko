import 'package:flutter/material.dart';
import 'package:spaciko/responsive.dart';

class FloatingQuickAccessBar extends StatefulWidget {
  final Function(int) onChange;
  const FloatingQuickAccessBar({
    Key key,
    @required this.screenSize,@required this.onChange,
  }) : super(key: key);

  final Size screenSize;

  @override
  _FloatingQuickAccessBarState createState() => _FloatingQuickAccessBarState();
}

class _FloatingQuickAccessBarState extends State<FloatingQuickAccessBar> {
  List _isHovering = [false, false, false, false,false];
  List<Widget> rowElements = [];

  List<String> items = ['Compass', 'Calender', 'Add', 'Comment','User'];

  List<Widget> generateRowElements() {
    rowElements.clear();
    for (int i = 0; i < items.length; i++) {
      Widget elementTile = InkWell(
        onHover: (value) {
          setState(() {
            value ? _isHovering[i] = true : _isHovering[i] = false;
          });
        },
        onTap: () {
            widget.onChange(i);
        },
        child: Text(
          items[i],
          style: TextStyle(
          ),
        ),
      );
      Widget spacer = SizedBox(
        height: 25,
        child: VerticalDivider(
          width: 1,
          color: Colors.blueGrey[100],
          thickness: 1,
        ),
      );
      rowElements.add(elementTile);
      if (i < items.length - 1) {
        rowElements.add(spacer);
      }
    }
    return rowElements;
  }
  @override
  Widget build(BuildContext context) {

    return Center(
        heightFactor: 1,
        child: Padding(
          padding: EdgeInsets.only(
            top: widget.screenSize.height * 0.08,
            left: Responsive.isSmallScreen(context)
                ? widget.screenSize.width / 12
                : widget.screenSize.width / 5,
            right: Responsive.isSmallScreen(context)
                ? widget.screenSize.width / 12
                : widget.screenSize.width / 5,
          ),
          child:  Card(
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.only(
                top: widget.screenSize.height / 50,
                bottom: widget.screenSize.height / 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: generateRowElements(),
              ),
            ),
          ),
        ),
    );
  }
}
