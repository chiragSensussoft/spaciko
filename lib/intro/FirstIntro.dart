import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spaciko/widgets/Pelette.dart';

import 'SecondIntro.dart';

void main() => runApp(FirstIntro());

class FirstIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        body:  _IntroState(),
      ),
    );
  }
}

class _IntroState extends StatelessWidget{
  const _IntroState({Key key,}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                        (context,index) =>  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height/1.7,
                          width: MediaQuery.of(context).size.width,
                          child: Image(
                            image: AssetImage('image/second_intro.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(margin: const EdgeInsets.only(top: 15,left: 15,right: 15),
                          child: Text('CREATING HAS NEVER BEEN EASIER',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,fontSize: 17),
                          ),
                        ),
                        Container(margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
                          alignment: Alignment.center,
                          child: Text.rich(
                            TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: 'Spaciko',style: TextStyle(color: Pelette.ColorPrimaryDark,fontSize: 18,fontWeight: FontWeight.w600)),
                                  TextSpan(text: ',Setting new Standards on leasing a Private Working space!',style: TextStyle(color: Colors.black87,fontSize: 18))
                                ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(margin: const EdgeInsets.only(top: 10),
                          child: Text('Now, you set the scene!',textAlign: TextAlign.center,style: TextStyle(color: Colors.black87,fontSize: 16)),
                        ),
                      ],
                    ),
                    childCount: 1
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                fillOverscroll: true,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('image/light_green.png')
                        ,fit: BoxFit.cover
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            child:  GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SecondIntro()
                                ));
                              },
                              child: Image(
                                image: AssetImage('image/red_round.png'),
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            child: Text('Become a host',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                          )
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child:  GestureDetector(
                              onTap: (){},
                              child: Image(
                                image: AssetImage('image/light_red_round.png'),
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 100,
                            child: Text('Work Any Where',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                          )
                        ],
                      )
                    ],
                  ),
                ),
             )
          ],
       ),
    );
  }
}