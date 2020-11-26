import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(home: MyList());
}

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  List<String> propList = [];
  int select=-1;
   List<String> numbers = ['Hourly','Daily','Monthly','Property Type'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My List'),
      ),
      body: Container(
        height: 50,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: numbers.length,
            itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              print(index);

              setState((){
                select=index;
              });

              if(propList.contains(index.toString())){
                propList.remove(index.toString());
                print(propList.toString());
              }
              else{
                propList.add(index.toString());
                print(propList.toString());
              }
            },

            child: Container(margin: const EdgeInsets.only(right: 2),
              width: MediaQuery.of(context).size.width /4,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0xff18a499),
                        width: 2
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: propList.contains(index.toString())?Colors.white:Color(0xff18a499),
            ),
                child: Container(
                  child: Center(child: Text(numbers[index], style: TextStyle(color: propList.contains(index.toString())?Color(0xff18a499):Colors.white, fontSize: 15.0),)),
                ),
              ),
            ),
          );
        }),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}