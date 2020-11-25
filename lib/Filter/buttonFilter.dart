import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';

import '../choice_chip_widget.dart';

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
List<String> splashList =[];
var toast = Toast();
Color clr;

class _ButtonFilterState extends State<ButtonFilter> {
  // var buttonFilter =   ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: buttonItem.length,
  //
  //     itemBuilder: (BuildContext context, int index) {
  //       return Column(
  //         children: [
  //           FlatButton(
  //                 height: 40,
  //                 minWidth: MediaQuery.of(context).size.width/4,
  //                 padding: const EdgeInsets.only(left: 10),
  //                 color: clr,
  //                 child: Center(child: Text(buttonItem[index],style: TextStyle(fontSize: 13,color: Colors.white,fontWeight: FontWeight.w500),)),
  //               ),
  //           ],
  //       );
  //     }
  // );
  List<String> butonsText = List();
  List<String> buttonItem = ['Hourly','Daily','Monthly','Property Type'];

  List<String> _selectedTextList = List();
  List<String> allTextList1;

  @override
  void initState() {
    _selectedTextList = buttonItem != null
        ? List.from(buttonItem)
        : [];
    super.initState();
  }
  List<Widget> _buildChoiceList(List<String> list) {
    List<Widget> choices = List();
    list.forEach(
          (item) {
        var selectedText = butonsText.contains(item);
        choices.add(
          ChoicechipWidget(
            onSelected: (value) {
              setState(
                    () {
                  selectedText
                      ? butonsText.remove(item)
                      : butonsText.add(item);
                },
              );
            },
            selected: selectedText,
            selectedTextColor: Pelette.ColorWhite,
            selectedTextBackgroundColor: Pelette.ColorPrimaryDark,
            unselectedTextBackgroundColor: Pelette.ColorWhite,
            unselectedTextColor: Pelette.ColorPrimaryDark,
            text: item,
          ),
        );
      },
    );
    return choices;
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
      );
  }
}