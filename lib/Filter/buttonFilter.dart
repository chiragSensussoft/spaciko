import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';

class ButtonFilter extends StatefulWidget {
  final Function(int) onChange;
  const ButtonFilter({
    Key key,
    @required this.screenSize,@required this.onChange,
  }) : super(key: key);
  final Size screenSize;

  @override
  _ButtonFilterState createState() => _ButtonFilterState();
}
List<String> buttonItem = ['Hourly','Daily','Monthly','Property Type'];

class _ButtonFilterState extends State<ButtonFilter> {
  var buttonFilter =   ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: buttonItem.length,

      itemBuilder: (BuildContext context, int index) {
        return Column(
            children: [
              Container(margin: const EdgeInsets.only(left: 4,top: 5),
                height: 40,
                width: MediaQuery.of(context).size.width/4.09,
                decoration: BoxDecoration(
                    color: Pelette.ColorPrimaryDark,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text(buttonItem[index],style: TextStyle(fontSize: 13,color: Colors.white),)),
              ),
            ],
        );
      }
  );
  List<Widget> rowElements = [];

  List<Widget> generateRowElements() {
    rowElements.clear();
    for (int i = 0; i < buttonItem.length; i++) {
      Widget elementTile = InkWell(
        onTap: () {
          widget.onChange(i);
        },
        child: Text(
          buttonItem[i],
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
      if (i < buttonItem.length - 1) {
        rowElements.add(spacer);
      }
    }
    return rowElements;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(padding: const EdgeInsets.fromLTRB(10, 5, 10,0),
                child: Material(
                  elevation: 1,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Search View',
                          border: OutlineInputBorder(borderRadius: BorderRadius.zero,borderSide: BorderSide.none)
                      ),
                    ),
                ),
              )
            ),
      body: Container(
        child: buttonFilter,
      ),
    );
  }
}
