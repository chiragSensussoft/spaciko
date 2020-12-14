import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';

import '../CustomChatBubble.dart';

class Bubble extends StatelessWidget {
  final bool isMe;
  final String message;

  Bubble({this.isMe, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        !isMe? Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(margin: const EdgeInsets.only(bottom: 3),
              height: 35,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: Text('H'),
                // backgroundImage: AssetImage('image/logo.png'),
              ),
            ),
            Flexible(
              child: Container(margin: const EdgeInsets.only(left: 5,bottom: 5,top: 5),
                padding: EdgeInsets.only(right: 100),
                child: CustomPaint(
                    painter: CustomChatBubble(color: AppColors.colorGre, isOwn: false),
                    child: Container(
                      // margin: const EdgeInsets.only(right: 50),
                        padding: EdgeInsets.all(15),
                        child: Text(message,
                          style: TextStyle(color: Colors.black),
                        )
                    )
                ),
              ),
            ),
          ],
        ) :Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(margin: const EdgeInsets.only(right: 5,bottom: 5,top: 5),
                padding: const EdgeInsets.only(left: 100),
                child: CustomPaint(
                    painter: CustomChatBubble(color: AppColors.colorGre, isOwn: true),
                    child: Container(
                        padding: EdgeInsets.all(15),
                        child: Text(message,
                          style: TextStyle(color: Colors.black),
                        )
                    )
                ),
              ),
            ),
            Container(margin: const EdgeInsets.only(bottom: 3),
              height: 35,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: Text('C'),
                // backgroundImage: AssetImage('image/logo.png'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
