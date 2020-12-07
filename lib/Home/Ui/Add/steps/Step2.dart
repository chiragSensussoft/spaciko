import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';

class Step2 extends StatefulWidget {
  int curStep;
  Function(int) onChange;
  Step2({Key key,this.curStep,this.onChange}): super(key: key);
  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  furnished _character;
  workingStation _station;
  Hosted _hosted;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: Hosted.New,
                          groupValue: _hosted,
                          onChanged: (Hosted value) {
                            setState(() {
                              _hosted = value;
                            });
                          },
                        ),
                        Container(
                          child: Text.rich(
                            TextSpan(text: 'No i\'m new to all this'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: Hosted.experienced,
                          groupValue: _hosted,
                          onChanged: (Hosted value) {
                            setState(() {
                              _hosted = value;
                            });
                          },
                        ),
                        Container(
                          child: Text.rich(
                            TextSpan(text: 'Yes,i\'m experienced with space hosting'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(margin: const EdgeInsets.only(top: 10),
                child: Text('How big  is your place',style: TextStyle(fontSize: 15,fontFamily: 'poppins_medium'),),
              ),
              Container(margin: const EdgeInsets.only(top: 10,left: 20,right: 20),
                height: 40,
                child: FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  minWidth: MediaQuery.of(context).size.width,
                  color: Pelette.ColorPrimaryDark,
                  onPressed: (){
                    widget.onChange(widget.curStep);
                    print(widget.curStep);
                  },
                  child: Text('Continue',style: TextStyle(color: Pelette.ColorWhite),),
                ),
              )
            ],
          ),
        )
    );
  }
}

enum furnished { Yes, No }
enum workingStation { shared, private }
enum Hosted {New, experienced }
