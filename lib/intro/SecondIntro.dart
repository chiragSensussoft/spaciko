import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/Home/Home.dart';
import 'package:spaciko/widgets/Pelette.dart';

class SecondIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Intro(),
    );
  }
}

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.black,
        )
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('image/third_intro.png'),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(margin: const EdgeInsets.only(top: 80),
                  child: Text(
                    'HOST THE WORK SPACE REVOLUTION!',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),
                  ),
                ),
                Container(margin: const EdgeInsets.only(top: 25),
                  child: Text('Got Free Space?',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
                ),
                Container(margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
                  child: Text('Share Your Space With Thousands Of Startups and Freelancers Instantly ready to book it!',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
                ),
              ],
            ),
          Container(margin: const EdgeInsets.only(bottom: 10),
                child: Material(
                  color: Color(0xffE92D5B),
                  borderRadius: BorderRadius.circular(25),
                  child: FlatButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => Home()
                      ));
                    },
                    child: Text('BECOME A HOST',style: TextStyle(color: Colors.white),),
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

