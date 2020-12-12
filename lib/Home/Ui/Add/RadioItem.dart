import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';

import 'Model/RadioModel.dart';

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: new EdgeInsets.all(10.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 20.0,
            width: 20.0,
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? AppColors.colorPrimaryDark
                  : Colors.white,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? Colors.white
                      : Colors.white),
              borderRadius: const BorderRadius.all(const Radius.circular(30)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(_item.text),
          )
        ],
      ),
    );
  }
}