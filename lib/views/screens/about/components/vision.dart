import 'package:ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';


class Vision extends StatefulWidget {



  const Vision({Key? key,

  }) : super(key: key);

  @override
  State<Vision> createState() => _VisionState();
}

class _VisionState extends State<Vision> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: DefaultTabController(
          length: 2,
            child: NestedScrollView(

              body: TabBarView(
                
                children: [

                  LocalizedVision(),

                  GlobalizedVision()

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

class LocalizedVision extends StatelessWidget {
  const LocalizedVision({
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
        "As we preach the full message of this new life, our goal is to raise a people who are like Jesus by exposing them to the influence of God’s word and His Spirit in an atmosphere of LOVE so that they may be able to take the LOVE of God, the WORD of God and the HEALING POWER of God to every individual within their sphere of contact.",

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





class GlobalizedVision extends StatelessWidget {
  const GlobalizedVision({
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
        'To take the LOVE of GOD, the WORD of GOD and the HEALING POWER of GOD to every INDIVIDUAL, every HOME, every CITY, every STATE, every NATION, every CONTINENT, everyday through every available means.',

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