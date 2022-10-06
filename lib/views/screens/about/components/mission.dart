import 'package:ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';


class Mission extends StatefulWidget {



  const Mission({Key? key,

  }) : super(key: key);

  @override
  State<Mission> createState() => _MissionState();
}

class _MissionState extends State<Mission> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: DefaultTabController(
          length: 2,
            child: NestedScrollView(

              body: TabBarView(
                
                children: [

                  LocalizedMission(),

                  GlobalizedMission()

               ],
              ),





              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) => [
                SliverPadding(
                  padding: EdgeInsets.all(8),
                  sliver: SliverToBoxAdapter(
                    child: Container(),
                  ),
                ),









                
                SliverAppBar(

                  expandedHeight: 100,

                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      'assets/images/bg.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  pinned: true,
                  elevation: 0,
                  titleSpacing: 0.0,
                  toolbarHeight: 10,
                  bottom: TabBar(



                    tabs: [
                    Tab(
                      child: Text(
                        'Localized',

                        style: TextStyle(
                              fontSize: 16,
                              color: general_text_color,
                              fontWeight: FontWeight.bold
                            ),
                      )
                      ),
                    
                    Tab(
                      child: Text(
                        "Globalized",

                        style: TextStyle(
                              fontSize: 16,
                              color: general_text_color,
                              fontWeight: FontWeight.bold
                            ),
                  
                      ),
                    ),
                    
                  ]),
                ),
              ],
            ),
          ),
  
      );
    
  }
}

class LocalizedMission extends StatelessWidget {
  const LocalizedMission({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
       top: 10,
       bottom: 15,
       left: 40,
       right: 30,
      ),
      child: Text(
        "To reach every Individual in this World with the Gospel in Order to raise fully functioning followers of Christ in every Nation.",

        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 20,
          color: general_text_color,
          height: 2.4,
          wordSpacing: 2
        ),
      ),
    );
  }
}





class GlobalizedMission extends StatelessWidget {
  const GlobalizedMission({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
       top: 10,
       bottom: 15,
       left: 40,
       right: 30

      ),
      child: Text(
        'To reach the world with the gospel in order to raise a people who are like Jesus.',

        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 20,
          color: general_text_color,
          height: 2.4,
          wordSpacing: 2
        ),
      ),
    );
  }
}