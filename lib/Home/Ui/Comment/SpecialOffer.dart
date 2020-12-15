import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';

void main() => runApp(SpacialOffer());
class SpacialOffer extends StatefulWidget {
  @override
  _SpacialOfferState createState() => _SpacialOfferState();
}

class _SpacialOfferState extends State<SpacialOffer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: AppColors.colorLightBlue50,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        ),
        child: Container(
          child: _spacialOffer(),
        ),
      ),
    );
  }

  Widget _spacialOffer(){
    return  Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (_,index){
            return Container(margin: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                    Container(
                      height: 90,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        elevation: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(padding: const EdgeInsets.only(left: 10),
                                  height: 70,
                                  width: 70,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black54,
                                    child: Text('C'),
                                    // backgroundImage: AssetImage('image/logo.png'),
                                  ),
                                ),
                                Container(margin: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Chirag Patel',style: TextStyle(fontSize: 15,color: Colors.black87)),
                                      Text('Host',style: TextStyle(fontFamily: 'poppins_bold',color: Colors.black45,fontSize: 15),
                                        textAlign: TextAlign.left,)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Container(margin: const EdgeInsets.only(right: 10),
                                alignment: Alignment.centerRight,
                                height: 30,
                                width: MediaQuery.of(context).size.width *0.30,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                  minWidth: MediaQuery.of(context).size.width,
                                  color: AppColors.colorPink,
                                  onPressed: (){
                                  },
                                  child: Center(child: Text('Contact Host',style: TextStyle(color: AppColors.colorWhite
                                  ,fontFamily: 'poppins_semibold',fontSize: 12),)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Container(margin: const EdgeInsets.only(top: 10),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(margin: const EdgeInsets.only(top: 5,right: 8),
                                  child: Image.asset('image/ic_user_themecolor.png',height: 20,width: 20,),
                                ),
                                Text('4 guests',style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'poppins_regular'),)
                              ],
                            ),
                            Container(margin: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                   Expanded(
                                     child: Row(
                                       children: [
                                         Container(margin: const EdgeInsets.only(top: 5,right: 8),
                                           child: Image.asset('image/ic_calender_green.png',height: 20,width: 20,),
                                         ),
                                         Flexible(
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Text('Dec. 14 2020',style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'poppins_regular'),),
                                               Text('04:30 Pm ',style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'poppins_regular'),)
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                    Expanded(
                                      child: Container(
                                        child: Icon(Icons.arrow_forward,color: AppColors.colorPrimaryDark,),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(margin: const EdgeInsets.only(top: 5,right: 8),
                                            child: Image.asset('image/ic_calender_green.png',height: 20,width: 20,),
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Dec. 14 2020',style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'poppins_regular'),),
                                                Text('04:30 Pm ',style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'poppins_regular'),)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Container(margin: const EdgeInsets.only(top: 10),
                              color: Colors.black45,
                              height: 0.7,
                            ),
                            Container(margin: const EdgeInsets.only(top: 5),
                              alignment: Alignment.bottomLeft,
                              child: Text('Payment Breakdown',style: TextStyle(color: Colors.black,
                              fontFamily: 'poppins_bold',fontSize: 16),),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Text('9 Hours',style: TextStyle(color: Colors.black,
                                      fontFamily: 'poppins_regular',fontSize: 16),),
                                ),
                                Text('\$16',style: TextStyle(color: Colors.black,
                                    fontFamily: 'poppins_regular',fontSize: 16),),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Text('Security Deposite',style: TextStyle(color: Colors.black,
                                      fontFamily: 'poppins_regular',fontSize: 16),),
                                ),
                                Text('-',style: TextStyle(color: Colors.black,
                                    fontFamily: 'poppins_regular',fontSize: 16),),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Text('Service Fee',style: TextStyle(color: Colors.black,
                                      fontFamily: 'poppins_regular',fontSize: 16),),
                                ),
                                Text('\$2',style: TextStyle(color: Colors.black,
                                    fontFamily: 'poppins_regular',fontSize: 16),),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Text('VAT',style: TextStyle(color: Colors.black,
                                      fontFamily: 'poppins_regular',fontSize: 16),),
                                ),
                                Text('\$3',style: TextStyle(color: Colors.black,
                                    fontFamily: 'poppins_regular',fontSize: 16),),
                              ],
                            ),
                            Container(margin: const EdgeInsets.only(top: 10),
                              height: 0.7,
                              color: Colors.black45,
                            ),
                            Container(margin: const EdgeInsets.only(top: 5,bottom: 5),
                              alignment: Alignment.center,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Original Payout',style: TextStyle(color: Colors.black,
                                        fontFamily: 'poppins_bold',fontSize: 16),),
                                  ),
                                  Text('\$21',style: TextStyle(color: Colors.black,
                                      fontFamily: 'poppins_bold',fontSize: 16),),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(margin: const EdgeInsets.only(right: 10),
                            alignment: Alignment.centerRight,
                            height: 35,
                            width: MediaQuery.of(context).size.width / 2,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              minWidth: MediaQuery.of(context).size.width,
                              color: AppColors.colorPink,
                              onPressed: (){
                              },
                              child: Center(child: Text('Accept',style: TextStyle(color: AppColors.colorWhite
                                  ,fontFamily: 'poppins_semibold',fontSize: 12),)),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(margin: const EdgeInsets.only(right: 10),
                            alignment: Alignment.centerRight,
                            height: 35,
                            width: MediaQuery.of(context).size.width / 2,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              minWidth: MediaQuery.of(context).size.width,
                              color: AppColors.colorPrimaryDark,
                              onPressed: (){
                              },
                              child: Center(child: Text('Declin',style: TextStyle(color: AppColors.colorWhite
                                  ,fontFamily: 'poppins_semibold',fontSize: 12),)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
      ),
    );
  }
}