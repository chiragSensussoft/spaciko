import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';

class Step2 extends StatefulWidget {
  int curStep;
  Function(int) onChange;
  Step2({Key key,this.curStep,this.onChange}): super(key: key);
  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  final _formKey = GlobalKey<FormState>();
  Toast _toast = Toast();

  int isFurnished = 0;
  int isPrivate = 0;
  int isExperienced = 0;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'is your space fully furnished?',
                  style: TextStyle(fontFamily: 'poppins_medium', fontSize: 15),
                ),
                Container(
                  margin:  EdgeInsets.all(10.0),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          children: [
                            Container(margin: const EdgeInsets.only(right: 2),
                              height: 20.0,
                              width: 20.0,
                              decoration:  BoxDecoration(
                                color: isFurnished == 1 ? Pelette.ColorPrimaryDark : Colors.white,
                                borderRadius: const BorderRadius.all(const Radius.circular(30)),
                              ),
                            ),
                            Text('Yes'),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            isFurnished = 1;
                          });
                        },
                      ),
                      GestureDetector(
                        child: Row(
                          children: [
                            Container(margin: const EdgeInsets.only(left: 10,right: 2),
                              height: 20.0,
                              width: 20.0,
                              decoration:  BoxDecoration(
                                color: isFurnished == -1 ? Pelette.ColorPrimaryDark : Colors.white,
                                borderRadius: const BorderRadius.all(const Radius.circular(30)),
                              ),
                            ),
                           Text('No'),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            isFurnished = -1;
                          });
                        },
                      )
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
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(25),
                    child: TextFormField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0)),
                    ),
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
                  margin:  EdgeInsets.all(10.0),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          children: [
                            Container(margin: const EdgeInsets.only(right: 2),
                              height: 20.0,
                              width: 20.0,
                              decoration:  BoxDecoration(
                                color: isPrivate == 1
                                    ? Pelette.ColorPrimaryDark
                                    : Colors.white,
                                borderRadius: const BorderRadius.all(const Radius.circular(30)),
                              ),
                            ),
                            Text('Shared'),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            isPrivate = 1;
                          });
                        },
                      ),
                      GestureDetector(
                        child: Row(
                          children: [
                            Container(margin: const EdgeInsets.only(left: 10,right: 2),
                              height: 20.0,
                              width: 20.0,
                              decoration:  BoxDecoration(
                                color: isPrivate == -1
                                    ? Pelette.ColorPrimaryDark
                                    : Colors.white,
                                borderRadius: const BorderRadius.all(const Radius.circular(30)),
                              ),
                            ),
                            Text('Private'),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            isPrivate = -1;

                          });
                        },
                      )
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
                  height: 70,
                  margin:  EdgeInsets.all(10.0),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          children: [
                            Container(
                              height: 20.0,
                              width: 20.0,
                              decoration:  BoxDecoration(
                                color: isExperienced == 1
                                    ? Pelette.ColorPrimaryDark
                                    : Colors.white,
                                borderRadius: const BorderRadius.all(const Radius.circular(30)),
                              ),
                            ),
                            Text('No i\'m new to all this'),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            isExperienced = 1;
                          });
                        },
                      ),
                      GestureDetector(
                        child: Row(
                          children: [
                            Container(margin: const EdgeInsets.only(top: 20),
                              height: 20.0,
                              width: 20.0,
                              decoration:  BoxDecoration(
                                color: isExperienced == -1
                                    ? Pelette.ColorPrimaryDark
                                    : Colors.white,
                                borderRadius: const BorderRadius.all(const Radius.circular(30)),
                              ),
                            ),
                            Container(margin: const EdgeInsets.only(top: 20),
                                child: Text('Yes,i\'m experienced with space hosting',overflow: TextOverflow.ellipsis,)),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            isExperienced = -1;
                          });
                        },
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
                      if(isFurnished==0||isExperienced==0||isPrivate==0){
                        setState(() {
                          _toast.overLay = false;
                        });
                        _toast.showOverLay('Fill up First', Colors.white, Colors.black54, context);
                      }else{
                        widget.onChange(widget.curStep);
                      }
                    },
                    child: Text('Continue',style: TextStyle(color: Pelette.ColorWhite),),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}