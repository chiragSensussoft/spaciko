import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpacialOffer extends StatefulWidget {
  @override
  _SpacialOfferState createState() => _SpacialOfferState();
}

class _SpacialOfferState extends State<SpacialOffer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Row(
                  children: [
                    CircleAvatar(

                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
