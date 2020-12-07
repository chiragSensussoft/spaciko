import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Step2 extends StatefulWidget {
  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  furnished _character;
  workingStation _station;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Text(
              'is your space fully furnished?',
              style: TextStyle(fontFamily: 'poppins_medium', fontSize: 15),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: furnished.Yes,
                    groupValue: _character,
                    onChanged: (furnished value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                  Text('Yes'),
                  Radio(
                    value: furnished.No,
                    groupValue: _character,
                    onChanged: (furnished value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                  Text('No'),
                ],
              ),
            ),
            Container(
              child: Text(
                'How Many RoomS do You Offer?',
                style: TextStyle(fontSize: 15, fontFamily: 'poppins_medium'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 0, right: 0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: TextFormField(
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0)),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Text(
                'Are your Working Station/dask shared or private?',
                style: TextStyle(fontSize: 15, fontFamily: 'poppins_medium'),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: workingStation.shared,
                    groupValue: _station,
                    onChanged: (workingStation value) {
                      setState(() {
                        _station = value;
                      });
                    },
                  ),
                  Text('Shared'),
                  Radio(
                    value: workingStation.private,
                    groupValue: _station,
                    onChanged: (workingStation value) {
                      setState(() {
                        _station = value;
                      });
                    },
                  ),
                  Text('Private'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Have you ever hosted your venue with a website like a spaciko before?',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'poppins_medium', fontSize: 15),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: workingStation.shared,
                    groupValue: _station,
                    onChanged: (workingStation value) {
                      setState(() {
                        _station = value;
                      });
                    },
                  ),
                  Container(
                    child: Text.rich(
                      TextSpan(text: 'Yes,i\'m experienced with space hosting'),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

enum furnished { Yes, No }
enum workingStation { shared, private }
