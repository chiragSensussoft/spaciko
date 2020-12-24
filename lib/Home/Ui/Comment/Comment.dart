import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:spaciko/Home/Ui/Comment/SpecialOffer.dart';
import 'package:spaciko/widgets/Pelette.dart';

import 'Widget/Bubble.dart';

void main() => runApp(CommentScreen());

class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextStyle textStyle = TextStyle(color: Colors.white);
  List<String> temp = List<String>();
  String msg;
  TextEditingController _controller = TextEditingController();

  int _curStep =0;
  bool title = false;
  bool btn = true;

  @override
  void initState() {
    super.initState();
    temp.add('Hello');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: AppColors.colorPrimaryDark,
          child: Column(
            children: [
              Container(padding: const EdgeInsets.only(left: 15,right: 15,top: 30),
                  alignment: Alignment.centerLeft,
                  color: AppColors.colorPrimaryDark,
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
                        onTap: (){
                          title = false;
                          btn = true;
                          setState(() {
                           _curStep =0;
                          });
                        },
                      ),
                      Visibility(
                        visible: title,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text('Spacial Offer',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,
                          fontFamily: 'poppins_semibold',fontSize: 20),),
                        ),
                      ),
                      Visibility(
                        visible: btn,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              title = true;
                              btn = false;
                              _curStep =1;
                            });
                            print(_curStep);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 110,
                            decoration: BoxDecoration(
                              color: AppColors.colorPink,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text('Spacial Offer',style:
                            TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'poppins_semibold'),textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    ],
                  )
              ),

              Expanded(
                child:_curStep==0?Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorLightBlue50,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                     _chat(),
                      Column(
                        children: [
                          Container(
                            margin:const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            color:Colors.white,
                            child: Text('Translate this conversation to english powered by google',textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black87,fontSize: 17,fontFamily: 'poppins_regular'),),
                          ),
                          Stack(
                            children: [
                              Container(margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black54)
                                ),
                                child: Form(
                                  child: TextFormField(
                                    onChanged: (String val){
                                      msg = val;
                                    },
                                    controller: _controller,
                                    decoration: InputDecoration(
                                      focusColor: Colors.black,
                                        enabledBorder: InputBorder.none,
                                        contentPadding: const EdgeInsets.fromLTRB(
                                            20, 0, 50, 0),
                                       border: InputBorder.none,
                                      hintText: 'Type message...',
                                      hintStyle: TextStyle(fontSize: 18)
                                    ),
                                  ),
                                ),
                              ),
                              Container(padding: const EdgeInsets.only(right: 15),
                                height: 50,
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  child:Image(
                                    height: 40,
                                    width: 40,
                                    image: AssetImage('image/ic_send_msg.png'),
                                  ),
                                  onTap: (){
                                   setState(() {
                                     sendFcmMessage(_controller.text);
                                     temp.add(msg);
                                     _controller.clear();
                                     scrollController.animateTo(
                                       scrollController.position.maxScrollExtent,
                                       curve: Curves.easeIn,
                                       duration: const Duration(milliseconds: 200),
                                     );
                                   });
                                  },
                                )
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ):SpacialOffer()
              )
            ],
          ),
        )
    );
  }

  static Future<bool> sendFcmMessage(String msg) async {
    try {
      var url = 'https://fcm.googleapis.com/fcm/send';
      var header = {
        "Content-Type": "application/json",
        "Authorization":
        "key=AAAAcbLNDRI:APA91bGkf5wnZQDLKWtnHUw_HtVhiyuRD9_GVTJfOKHKnWllGUe3uSsg6rfvuW1hX2uTMeeipeofW7KtoQs3OX-axUsE-g7aS1xdsJcUmuntq6po7h2wSmP_njhZan1F5pZECgt6OaOL",
      };
      var request = {
        "notification": {
          "title": 'Spaciko',
          "text": msg,
          "sound": "default",
          "color": "#990000",
        },
        "priority": "high",
        "to": "cyOXVZmdT5egWotf5zuBnq:APA91bHGmLORJx6PmGeZsUN41Z_tIgnq_jwxgqnXyoxNSlIY1-uqPAvoeH3nVs-LjuiTak4ZVwxsjlCa9jr1SxppPgSyY6TFMH6cqKEbsSDnfjeuZZnyl7qozRKfSp7oOLpH8zNa7a04",
      };
      var client = new Client();
      var response = await client.post(url, headers: header, body: json.encode(request));
      if(response.statusCode ==200){
        print('Success');
       return true;
      }
      return true;
    } catch (e, s) {
      print(e);
      return false;
    }

  }
  var scrollController = ScrollController();
  Widget _chat() {
    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        controller: scrollController,
        itemCount: temp.length,
        itemBuilder: (_, index) {
          return Container(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Bubble(isMe: true,message: temp[index]),
                Bubble(isMe: false,message: temp[index].split('').reversed.join(),)
              ],
            ),
          );
        },
      ),
    );
  }
}
