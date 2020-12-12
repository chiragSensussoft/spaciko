import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';

import 'Widget/Bubble.dart';

class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextStyle textStyle = TextStyle(color: Colors.white);
  List<String> _chatList = List<String>();
  TextEditingController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: AppColors.colorPrimaryDark,
          child: Column(
            children: [
              Container(padding: const EdgeInsets.only(left: 15,right: 15),
                  alignment: Alignment.centerLeft,
                  color: AppColors.colorPrimaryDark,
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
                        onTap: (){
                        },
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 35,
                        width: 110,
                        decoration: BoxDecoration(
                          color: AppColors.colorPink,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text('Spacial Offer',style:
                        TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'poppins_semibold'),textAlign: TextAlign.center,),
                      )
                    ],
                  )
              ),
              Expanded(
                child: Container(
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
                              Container(margin: const EdgeInsets.only(left: 10,right: 10),
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black54)
                                ),
                                child: TextFormField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    focusColor: Colors.black,
                                      enabledBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                     border: InputBorder.none,
                                    hintText: 'Type message...',
                                    hintStyle: TextStyle(fontSize: 18)
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
                                    // setState(() {
                                    //   _chatList.add(_controller.text);
                                    //   print(_controller.text);
                                    // });
                                  },
                                )
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )
                )
              )
            ],
          ),
        )
    );
  }

  Widget _chat() {
    return Flexible(
      child: ListView.builder(
        itemCount: _chatList.length,
        itemBuilder: (_, index) {
          return Container(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Bubble(isMe: true,message: _chatList[index]),
              ],
            ),
          );
        },
      ),
    );
  }
}
