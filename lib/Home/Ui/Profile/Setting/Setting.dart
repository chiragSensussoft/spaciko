import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spaciko/widgets/Pelette.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this,initialIndex: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.colorPrimaryDark,
        child: Column(
          children: [
            Container(
              height: 80,
              child: Row(
                children: [
                  Container(margin: const EdgeInsets.only(left: 10),
                    width:10,
                    child: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),
                  ),
                  Flexible(
                    child: Container(margin: const EdgeInsets.only(right: 20),
                      child: Text('Booking',style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'poppins_semibold'),),
                      alignment: Alignment.center,
                    ),
                  )
                ],
              ),
            ),
            Container(padding: const EdgeInsets.only(left: 40,right: 40),
              height: 40,
              child: TabBar(
                controller: _tabController,

                labelColor: Colors.white,
                indicatorColor: AppColors.colorPink,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 5,color: AppColors.colorPink),
                ),
                tabs: [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    child: Text('Upcoming',style: TextStyle(color: Colors.white,fontSize: 16),),
                  ),

                  // second tab [you can add an icon using the icon property]
                  Tab(
                    child: Text('Previous',style: TextStyle(color: Colors.white,fontSize: 16),),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.colorLightBlue50,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                ),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // first tab bar view widget
                    Center(
                      child: _upcoming()
                    ),

                    Center(
                      child: Text(
                        'Previous',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget _upcoming(){
    return Container(padding: const EdgeInsets.only(top: 10),
      alignment: Alignment.topCenter,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 1,
        itemBuilder: (_,index){
          return Container(
            child:Card(
              child: Column(
                children: [
                    Container(
                      height: 200,
                    )
                ],
              ),
            )
          );
        },
      ),
    );
  }

}