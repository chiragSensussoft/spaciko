import 'package:flutter/cupertino.dart';

class Step4 extends StatefulWidget {
  int curStep;
  Function(int) onChange;
  Step4({Key key,this.curStep,this.onChange}): super(key: key);
  @override
  _Step4State createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(

        ),
      ),
    );
  }
}
