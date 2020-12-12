import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomChatBubble.dart';

class ChatSampleWidget extends StatefulWidget {
  @override
  _ChatSampleWidgetState createState() => _ChatSampleWidgetState();
}

class _ChatSampleWidgetState extends State<ChatSampleWidget> {
  TextEditingController _editingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  final TextStyle textStyle = TextStyle(color: Colors.white);
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatter'),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CustomPaint(
                          painter: CustomChatBubble(isOwn: false),
                          child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Message from someone else \n Says sometihngs',
                                style: textStyle,
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CustomPaint(
                          painter:
                          CustomChatBubble(color: Colors.grey, isOwn: false),
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: FlutterLogo())),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CustomPaint(
                          painter:
                          CustomChatBubble(color: Colors.green, isOwn: true),
                          child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Message from me',
                                style: textStyle,
                              ))),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          controller: _editingController,
                          focusNode: _focusNode,
                          decoration:
                          InputDecoration(hintText: 'Say something...'),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.send,
                            size: 30,
                          ),
                          onPressed: () {
                            print(_editingController.text);
                          })
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}