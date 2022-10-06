

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, await_only_futures



import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/awids.dart';
import 'package:ecommerce/utils/cards.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/views/screens/about/about_us.dart';
import 'package:ecommerce/views/screens/cricnews.dart';
import 'package:ecommerce/views/screens/devotional/addawids.dart';
import 'package:ecommerce/views/screens/meetings/meeting.dart';
import 'package:ecommerce/views/screens/month/components/addmonthly.dart';
import 'package:ecommerce/views/screens/month/monthly.dart';
import 'package:ecommerce/views/screens/profile.dart';
import 'package:ecommerce/views/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {

  final String uid;
  const HomeScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Monthly monthly = Monthly();

  Map<String, dynamic>? _month={
    'img':'assets/images/devo.jpg',
    'letter':'',
    'events':[]
  };

  Future<void> myMonth()async{

    final id = '${DateTime.now().month}_${DateTime.now().year}';
    final d=await monthly.getMonthData(id);
    setState(() {
      _month = d;
    });
    
  }





  List<AwidsCard> awidsCard = [];

   Future<void> devsAll(QuerySnapshot? docs) async{

      List<AwidsCard> awidsList = [];

      final allDocs = await docs?.docs;
      

      for (var doc in allDocs!) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        awidsList.add(
          AwidsCard(
            uid: widget.uid,
            id: data['id']??'',
            title: data['title']??'',
            body: data['body']??'',
            passage: data['passage']??'',
            openingScripture: data['openingScripture']??'',
            date: data['date']??'',
            instruction: data['instruction']??'',
            doingTheWord: data['doingTheWord']??'',
            furtherScripture: data['furtherScripture']??'',
            dailyScripture: data['dailyScripture']??'',
            bgImage: data['bgImage']??'',
            views: data['views']??0,
        
          )
        );
      }

      awidsList.sort(
        (a,b)=>b.date.compareTo(a.date)
      );

      setState(() {
        awidsCard = awidsList;
        getToday();
      });

      
   }

   List <AwidsCard> _today = [];
    
    void getToday(){
      for (var c in awidsCard) {
        DateTime awids_date = DateTime.parse(c.date);

        if (awids_date.year == DateTime.now().year){
          if (awids_date.month == DateTime.now().month){
            if (awids_date.day == DateTime.now().day)
            {
              _today.add(c);
              //awidsCard.remove(c);
            }

          }
        }
      }
    }

  final GlobalKey<ScaffoldState> _home = GlobalKey();

  @override
  void initState() {
    myMonth();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final devs = Provider.of<QuerySnapshot?>(context);
    devsAll(devs);

    return  Scaffold(
        key: _home,
        
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: bg_color,
              //pinned: true,
              snap: true,
              floating: true,
      
              //automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: (){
                    _home.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.sort,
                  size: 25,
                  color: general_text_color,
                ),
              ),
              
      
              actions: [
                IconButton(
                  onPressed: () {
      
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ProfileScreen(uid:widget.uid);
                      }
                    ));
      
            
      
                  }, 
                  padding: EdgeInsets.all(4),
                  icon: Icon(
                    MdiIcons.accountCircle,
                    color: Color.fromARGB(255, 133, 131, 124),
                    size: 27,
                    ))
              ],
      
              centerTitle: true,
              title: Text("CRIC",
                style: TextStyle(
                  color: general_text_color,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
      
      
      
              expandedHeight: 130,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Container(
                        
                      ),
      
                      Container(
                        height: 44,
                        width: MediaQuery.of(context).size.width-(MediaQuery.of(context).size.width/9),
                        decoration: BoxDecoration(
                          color: bg_deep,
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
      
                          child: GestureDetector(
                            onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return SearchPage(
                                    uid: widget.uid,
                                  );
                                }
                              ));
                            }, 
                            
                            child: TextFormField(
                              style: TextStyle(
                                
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                enabled: false,
                                border: InputBorder.none,
                                icon: Icon(Icons.search),
                                iconColor: general_text_color,
                                hintText: 'search here',
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
      
              ),
            ),
      
      
             SliverToBoxAdapter(
              child: Outliner(
                outline: 'CRIC News',
              ),
            ),
      
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: SizedBox(
                  height: 180,
                  child: StreamBuilder<QuerySnapshot>(
                        stream: CricNewsDB().getNew,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                           final allNews = snapshot.data!.docs.map((doc)=>
                             doc.data() as Map<String, dynamic>
                           ).toList();

        
                         return Swiper(
                           itemCount: allNews.length,
                            autoplay: true,
                            
                            control: SwiperControl(),
                            pagination: SwiperPagination(),
                            itemBuilder: (BuildContext context, int index){
                              return ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl:allNews[index]['bgImage'],
                                  fit: BoxFit.fill,
                                  ),
                              );
                           
                           },
                         );
        
                       }

                       if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(
                             child: SizedBox(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator()
                                ),
                            );
                          }

                         return Container();

                       }
                     ),
                  //NewsSwipe(),
                ),
                ),
            ),
      
    
    
            SliverToBoxAdapter(
              child: _today.isNotEmpty?
               Outliner(
                outline: 'Today',
              ):
              Container()
            ),
      
      
            SliverToBoxAdapter(
              child: _today.isNotEmpty?
              AwidsCard(
              uid: widget.uid,
              id: _today[0].id,
              title: _today[0].title,
              body: _today[0].body,
              passage: _today[0].passage,
              openingScripture: _today[0].openingScripture,
              date: _today[0].date,
              instruction: _today[0].instruction,
              doingTheWord: _today[0].doingTheWord,
              furtherScripture: _today[0].furtherScripture,
              dailyScripture: _today[0].dailyScripture,
              bgImage: _today[0].bgImage,
              views: _today[0].views,
          
              )
              :
              Container()
            ),
      
      
            SliverToBoxAdapter(
              child: _today.isNotEmpty? Outliner(
                outline: 'Previous',
              ):
              Outliner(
                outline: 'Devotionals',
              ),
            ),
      
    
    
            awidsCard.isNotEmpty ?
      
             SliverList(
              
              delegate: SliverChildBuilderDelegate(
                (context, index){
                  return AwidsCard(
                    uid: awidsCard[index].uid,
                    id: awidsCard[index].id,
                    title: awidsCard[index].title, 
                    body: awidsCard[index].body,
                    passage: awidsCard[index].passage,
                    openingScripture: awidsCard[index].openingScripture,
                    date: awidsCard[index].date,
                    instruction: awidsCard[index].instruction,
                    doingTheWord: awidsCard[index].doingTheWord,
                    furtherScripture: awidsCard[index].furtherScripture,
                    dailyScripture: awidsCard[index].dailyScripture,
                    bgImage: awidsCard[index].bgImage,
                    views: awidsCard[index].views
                    );
                },
      
                childCount: awidsCard.length,
                
                )
              )
              :
              SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            ),
    
    
          ],
        ),
      
      
      
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context){
                            return ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                              child: Container(
                                color: bg_color,
                                height: 180,
                                padding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    TextButton.icon(
                                      onPressed: (){
                                        Navigator.pop(context);
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return CricNews();
                                            }
                                          ));
                                      },
                                      
                                      icon: Icon(
                                        Icons.newspaper_rounded,
                                        size: 20,
                                        color: cricGreen,
                                      ), 
                                      
                                      label: Text(
                                        'Add CRIC Update',
                                        style: TextStyle(
                                          wordSpacing: 2,
                                          color: general_text_color,
                                          fontSize: 18
                                        ),
                                      )),


                                      TextButton.icon(
                                      onPressed: (){
                                        Navigator.pop(context);
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return AddAwidsScreen();
                                            }
                                          ));
                                      },
                                      
                                      icon: Icon(
                                        Icons.book_online_rounded,
                                        size: 20,
                                        color: cricGreen,
                                      ), 
                                      
                                      label: Text(
                                        'Add Daily Devotional',
                                        style: TextStyle(
                                          wordSpacing: 2,
                                          color: general_text_color,
                                          fontSize: 18
                                        ),
                                      )),


                                      TextButton.icon(
                                      onPressed: (){
                                        Navigator.pop(context);
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return MonthData();
                                            }
                                          ));
                                      },
                                      
                                      icon: Icon(
                                        Icons.calendar_month,
                                        size: 20,
                                        color: cricGreen,
                                      ), 
                                      
                                      label: Text(
                                        'Add Monthly Data',
                                        style: TextStyle(
                                          wordSpacing: 2,
                                          color: general_text_color,
                                          fontSize: 18
                                        ),
                                      )),


                                  ],
                                ),
                              ),
                            );
                          }
                          );
          },
          
          backgroundColor: bg_color,

          child: Icon(
            Icons.add,
            color: cricGreen,
          ),

          
          ),

          





        /*SpeedDialFabWidget(
          primaryBackgroundColor: cricGreen,
          secondaryIconsList: [
            Icons.newspaper,
            Icons.book_rounded,
            Icons.calendar_month
          ],
          secondaryIconsOnPress: [
          (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return CricNews();
              }
            ));
            },
    
          (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
                return AddAwidsScreen();
              }
            ));
            },

          (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
                return MonthData();
              }
            ));
            }
    
          ],
    
          secondaryIconsText: [
            'CRIC News',
            'AWIDS',
            'month'
          ],
    
        ),

*/
        




      drawer: CustomDrawer(data: _month,),
      
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final Map<String, dynamic>? data;
  const CustomDrawer({
    Key? key,
    this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bg_color,

      child: ListView(

        children: [

          DrawerHeader(
            padding: EdgeInsets.all(0),
            child: CachedNetworkImage(
              imageUrl: data!['img'],
              fit: BoxFit.fill,
              placeholder: (context, url)
                =>
                  CircularProgressIndicator(),
            )
            ),



          ListTile(
            onTap: (){
              Navigator.pop(context);

              Navigator.push(context, MaterialPageRoute(builder: (context){
                return MyMonth(data: data,);
               },
               )
               );

              },
            leading: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 5, bottom: 5, right: 5
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      bg_deep, cricGreen, cricGreen, 
                    ])
                ),
                child: Icon(
                  MdiIcons.calendarAlert,
                  color: Colors.white,
                ),
              ),
            ),

            title: Text(
              'Month of ${['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'].elementAt(DateTime.now().month-1)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),

            subtitle: Text(
              'Calendar, Monthly letter, ...',
              style: TextStyle(
                fontSize: 12
              ),
            ),
          ),




          ListTile(
            onTap: (){
              Navigator.pop(context);
               Navigator.push(context, MaterialPageRoute(builder: (context){
                return Meeting();
               },
               )
               );
            },


            leading: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 5, bottom: 5, right: 5
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      bg_deep, cricGreen, cricGreen
                    ])
                ),
                child: Icon(
                  MdiIcons.clockTimeElevenOutline,
                  color: Colors.white,
                ),
              ),
            ),

            title: Text(
              'Our Meetings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),

            subtitle: Text(
              'Matters of the Heart, EQUIP, ...',
              style: TextStyle(
                fontSize: 12
              ),
            ),
          ),


/*
          ListTile(
            onTap: () => Navigator.pop(context),
            leading: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 5, bottom: 5, right: 5
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      bg_deep, cricGreen, cricGreen
                    ])
                ),
                child: Icon(
                  MdiIcons.phone,
                  color: Colors.white,
                ),
              ),
            ),

            title: Text(
              'Reach out here',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),

          ),

*/



          ListTile(

            onTap: () {
              Navigator.pop(context);
               Navigator.push(context, MaterialPageRoute(builder: (context){
                return AboutUs();
               },
               )
               );

              
              },

            leading: SizedBox(
              width: 28,
              height: 28,
              child: Image.asset(
                "assets/images/cric.png",
              ),
            ),

            title: Text(
              'Who we are',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),

            subtitle: Text(
              'Vision, Mission, ...',
              style: TextStyle(
                fontSize: 12
              ),
            ),

          ),

        ],
      ),
    );
  }
}



class Outliner extends StatelessWidget {

  final String outline;


  const Outliner({
    Key? key,
    required this.outline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15),
      child: Text(
        outline,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          letterSpacing: 2,
          color: general_text_color
        ),
        ),
    );
  }
}





