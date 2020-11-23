
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TandC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TC(),
    );
  }
}

class TC extends StatefulWidget {
  @override
  _TCState createState() => _TCState();
}

class _TCState extends State<TC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Pelette.ColorPrimaryDark,
      body: Container(margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
          ),
        child: WebView(
          onWebViewCreated: (WebViewController c){
            c.loadUrl('https://spaciko.com/terms');
          },
        ),
      ),
    );
  }
}