import 'package:flutter/material.dart';
class Toast {
  OverlayEntry overlayEntry;
  bool overLay = true;
  showOverLay(String msg,Color txtClr,Color bgClr,BuildContext context,{int seconds = 1,double top,double bottom,double left,double right}) async{
    OverlayState overlaystate = Overlay.of(context);
    overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          left: left,right: right,top: top,bottom: bottom,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    onPressed: () {},
                    child: Container( padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 15),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: bgClr,
                      ) ,
                      child: Text(msg,style: TextStyle(color:txtClr,)),
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
    overlaystate.insert(overlayEntry);
    await Future.delayed(Duration(seconds: seconds)).whenComplete((){
      overlayEntry.remove();
      overLay=true;
    });
  }
}