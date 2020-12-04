import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/Home/Ui/Add/steps/Step1.dart';
import 'package:spaciko/widgets/Pelette.dart';

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AddScreen(),);
  }
}

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Pelette.ColorPrimaryDark,
        child: Column(
          children: [
            Container(
              color: Pelette.ColorPrimaryDark,
              height: MediaQuery.of(context).size.height *0.16,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Pelette.colorLightBlue50,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    Container(padding: const EdgeInsets.only(left: 30,right: 30),
                      height: 50,
                      child: Stack(
                        children: [
                          Container(margin: const EdgeInsets.only(top: 10),
                            height: 30,
                            child: Center(
                              child: Container(
                                height: 2,
                                color: Pelette.ColorPrimaryDark,
                              ),
                            ),
                          ),
                          Container(
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height:50,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Pelette.ColorPrimaryDark,
                                    child: Text(
                                      "1",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:50,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Pelette.colorGreenTrans,
                                    child: Text(
                                      "2",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:50,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Pelette.colorGreenTrans,
                                    child: Text(
                                      "3",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:50,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Pelette.colorGreenTrans,
                                    child: Text(
                                      "4",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:50,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Pelette.colorGreenTrans,
                                    child: Text(
                                      "5",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:50,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Pelette.colorGreenTrans,
                                    child: Text(
                                      "6",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child:Container(
                          child: Step1(),
                      ),
                    )
                  ],
                )
              ),
            )
          ],
        ),
      )
    );
  }
}