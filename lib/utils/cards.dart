// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/awids.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/views/screens/read.dart';
import 'package:badges/badges.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';



class AwidsCard extends StatefulWidget {
  final String id;
  final String uid;
  final String title;
  final String body;
  final String passage;
  final String openingScripture;
  final String date;
  final String instruction;
  final String doingTheWord;
  final String furtherScripture;
  final String dailyScripture;
  final String bgImage;


  final int views;
  final String comments;
  final String likes;
  final String shares;




  const AwidsCard({
    Key? key,
    required this.id,
    required this.uid,
    this.title='',
    this.body='',
    this.passage='',
    this.openingScripture='',
    this.date= '',
    this.instruction='',
    this.doingTheWord='',
    this.furtherScripture='',
    this.dailyScripture='',
    this.bgImage='',

    this.likes='',
    this.views = 0,
    this.comments='',
    this.shares=''

  }) : super(key: key,);

  @override
  State<AwidsCard> createState() => _AwidsCardState();
}

class _AwidsCardState extends State<AwidsCard> {


  final awids = AwidsDB();

  final likes = AwidsLike();

  int allLikes = 0;

  Future<void> glikes()async{
    int n = await likes.getlike(widget.id);
    setState(() {
      allLikes = n;
    });
  }

  bool liked = false;

  Future<void> glikedStat()async{
    bool n = await likes.check_like(widget.uid, widget.id);
    setState(() {
      liked = n;
    });
  }


  String no_of_views = '';

  void numberOfViews(){
    if(widget.views==0){
      setState(() {
        no_of_views = '';
      });
      }
    if(widget.views>=1000){
      setState(() {
        no_of_views = '${(widget.views/1000).toStringAsFixed(1)}k';
      });
      }
    else if(widget.views>=1 && widget.views<=999){
      setState(() {
        no_of_views = '${widget.views}';
      });
    }
  }



  Future<void> viewed()async{
    await awids.addView(widget.id);
  }



  @override
  void initState() {
    glikes();
    glikedStat();
    numberOfViews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        viewed();

        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ReadDev(
            userId: widget.uid,
            devId: widget.id,
            title: widget.title,
            body: widget.body,
            passage: widget.passage,
            openingScripture: widget.openingScripture,
            date: widget.date,
            instruction: widget.instruction,
            doingTheWord: widget.doingTheWord,
            furtherScripture: widget.furtherScripture,
            dailyScripture: widget.dailyScripture,
            bgImage: widget.bgImage,
            likes:allLikes.toString(),
            
    
          );
          }));

        },
    
      child: FractionallySizedBox(
        widthFactor: .95,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: SizedBox(
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20), topRight: Radius.circular(10), bottomLeft: Radius.circular(10),),
              child: Container(
                color: Colors.white,
    
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: FractionallySizedBox(
                          heightFactor: .98,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              margin: EdgeInsets.all(20),
                              child: CachedNetworkImage(
                                imageUrl: widget.bgImage,
                                fit: BoxFit.cover,
                                placeholder: (context, url)=>
                              Image.asset(
                                'assets/images/devo.jpg',
                                fit: BoxFit.cover,
                                ),)
                            ),
                          ),
                        ),
                      ),
                    ),
    
                    Flexible(
                      flex: 8,
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 3, left: 10),
                            child: Text(
                              widget.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
    
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                              ),
                          ),
    
    
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3, left: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              child: Container(
                                padding: EdgeInsets.all(3),
                                color: Color.fromARGB(255, 22, 65, 44),
                                child: Text(
                                 widget.date.isNotEmpty ? DateFormat.yMMMEd().format(DateTime.parse(widget.date)) : DateFormat.yMMMEd().format(DateTime.now()),
                                  textAlign: TextAlign.left,
                            
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white
                                  ),
                                  ),
                              ),
                            ),
                          ),
    
    
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                            child: Text(
                              widget.body,
                              textAlign: TextAlign.left,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
    
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 14
                              ),
                              ),
                          ),
    
    
                          Padding(
    
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  TextButton.icon(
                                    onPressed: null,

                                        icon: Icon(
                                          Icons.thumb_up,
                                          color: liked==true? cricGreen : bg_deep,
                                          size: 16
                                           ),


                                        label: StreamBuilder<DocumentSnapshot>(
                                          stream: likes.justLike(widget.id),
                                          builder: (context, snapshot) {
                                            if(snapshot.hasData){
                                              DocumentSnapshot? _likes = snapshot.data;
                                              final data = _likes!.data() as Map<String, dynamic>;

                                              
                                              int nl = int.parse(data['like_number']);


                                              if(nl<=0){
                                                return Text('');//return Text('${data['like_number']}');
                                              }

                                              if(nl==1){
                                                return Text('$nl like');
                                              }

                                              if(nl > 1 && nl < 1000){
                                                return Text('$nl likes');
                                              }

                                              if(nl >= 1000){
                                                return Text('${(nl/1000).toStringAsFixed(1)}k likes');
                                              }

                                            }

                                            if(snapshot.connectionState == ConnectionState.waiting){
                    
                                              return Text('');
                                            }
                  
                                             return Text('');

                                          }
                                        ),

                                      ),
   
                                Badge(
                                  padding: EdgeInsets.all(5),
                                  badgeColor: Color.fromARGB(255, 4, 123, 44),
                                  showBadge: widget.comments.isNotEmpty?true:false,
                                  badgeContent: Text(
                                    widget.comments,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      color: bg_color,
                                      child: Icon(
                                       FontAwesomeIcons.comment,
                                        size:16,
                                        color: cricGreen,
                                      )
                                    ),
                                  ),
                                ),


                                  TextButton.icon(
                                    onPressed: null,

                                        icon: Icon(
                                          FontAwesomeIcons.eye,
                                          color: cricGreen,
                                          size: 16
                                           ),


                                        label: Text(
                                          no_of_views
                                        )
                                  )    
    

    
    
                              ],
                            ),
                          )
    
                        ],
                      ),
                    ),
    
                  ],
                ),
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}









class ReplyCard extends StatefulWidget {
  final List<Map<String, dynamic>> replies;
  const ReplyCard({
    Key? key,
    this.replies = const []

  }) : super(key: key);

  @override
  State<ReplyCard> createState() => _ReplyCardState();
}

class _ReplyCardState extends State<ReplyCard> {
  double _height = 40.0;
  int end = 0;
  bool fadeName = false;


  void getheight(){
    setState(() {
      if(widget.replies.isEmpty){_height=0.0;}
      if(widget.replies.length==1){_height=40.0;}
      if(widget.replies.length==2){_height=80.0;}
      if(widget.replies.length>2){_height=120.0;}
    });
  }

  @override
  void initState() {
    getheight();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.replies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.replies[index]['img']),
                  radius: 15,
                ),

                SizedBox(width: 10,),
                Text(
                  widget.replies[index]['name'],
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(width: 10,),

                Text(
                  widget.replies[index]['text'].toString().substring(0,
                    widget.replies[index]['name'].length + widget.replies[index]['text'].length>30 ? 30-widget.replies[index]['name'].length : widget.replies[index]['text'].length
                  ),
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15
                  ),
                ),
              ],
            ),
          );
        }
        ),
    );
  }
}













class InsightCard extends StatefulWidget {

  final String insight;
  final String insighterId;
  final String devId;
  final String insightId;

  final List<Map<String, dynamic>> replies;
  

  const InsightCard({Key? key,
  required this.insight,
  required this.insightId,
  this.devId = '',
  this.insighterId='',
  this.replies = const []
  }) : super(key: key);

  @override
  State<InsightCard> createState() => _InsightCardState();
}

class _InsightCardState extends State<InsightCard> {

  String _timePast = 'Just now';
  int days =0;

  void timePast(String millisec){
    int timeago = DateTime.now().millisecondsSinceEpoch - int.parse(millisec);
    double se = timeago/1000;
    int sec = se.round();

    if(sec>60){
      if(sec<3600){
        double c=sec/60;
        setState(() {
          _timePast = '${c.round()}m';
        });
      }


      else if(sec>=3600){
        if(sec<86400){
        double  c=sec/60/60;
        setState(() {
          _timePast = '${c.round()}h';
          days=(sec/60/60).round();
        });
      }


       else if(sec>=86400){
        if(sec<604800){
        double  c=sec/60/60/24;
        setState(() {
          _timePast = '${c.round()}d';
        });
      }

       else if(sec>=604800){
        if(sec<31536000){
        double  c=sec/60/60/24/7;
        setState(() {
          _timePast = '${c.round()}w';
        });
      }

       else if(sec>31536000){
        
        double  c=sec/60/60/24/365;
        setState(() {
          _timePast = '${c.round()}y';
          days=(sec/60/60).round();
        });

      }
      }

      }

      }
    }

  }


  Map<String, dynamic> user = {};





    final likes = InsightLikeReply();

    bool i_like=false;


    Future<void> iLike()async{
    bool l = await likes.check_like(widget.insighterId, widget.insightId);
    setState(() {
      i_like=l;
    });
  }

  Future<void> like()async{
    bool k = await likes.like(widget.insighterId, widget.insightId);
    setState(() {
      i_like=k;
    });
  }




  Future<void> getUser() async{
    Map<String, dynamic> userD = await CricUser(widget.insighterId).getUser();
    
    setState(() {
      user=userD;
    });
  }

  @override
  void initState() {
    getUser();
    iLike();
    timePast(widget.insightId);
    super.initState();
  }


  @override



  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      //color: insightColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    user['dp']
                  ),//NetworkImage(user['dp']),
                  backgroundColor: cricGreen,

                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    user['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: defaultFontSize
                    ),
                  ),
                )
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:60, right: 10,),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: insightColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)
                    )
                  ),
                  child: Text(
                    widget.insight,
                    style: TextStyle(
                      wordSpacing: 1.2,
                      fontSize: 16,
                    ),
                  )
                  ),
              ),


              Padding(
                padding: const EdgeInsets.only(left:60, right: 10, bottom: 5),
                child: Row(
                  children: [
                    
                    Text(
                          _timePast,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          
                        ),
                        ),

                    SizedBox(width:5,),


/*
                    TextButton.icon(
                      onPressed: ()async{
                            await like();
                        },

                      icon: Icon(
                        Icons.thumb_up_alt_rounded,
                        color: i_like==true? cricGreen : bg_deep,
                      ),

                      label: StreamBuilder<DocumentSnapshot>(
                stream: likes.justLike(widget.devId),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    DocumentSnapshot? _likes = snapshot.data;
                    final data = _likes!.data() as Map<String, dynamic>;
                    int nl = int.parse(data['like_number']);
                    if(nl<=0){
                      return Text('');//return Text('${data['like_number']}');
                    }

                    if(nl==1){
                      return Text('$nl like');
                    }

                    if(nl > 1 && nl < 1000){
                      return Text('$nl likes');
                    }

                    if(nl >= 1000){
                      return Text('${(nl/1000).toStringAsFixed(1)}k likes');
                    }

                  }

                  if(snapshot.connectionState == ConnectionState.waiting){
                    
                    return Text('');
                  }
                  
                   return Text('');

                }
              ),

                      ),

                    SizedBox(width: 5,),

*/

      //                TextButton(
      //                  onPressed: (){
      //                    
     //                   }, 
     //                   child: Text(
     //                     'Reply',
     //                   style: TextStyle(
     //                     color: Colors.black,
     //                     fontSize: 18,
     //                   ),
     //                   ))
                  ],
                ),
              )
            ],
          ),

//////replies to an insight
          Padding(
            padding: const EdgeInsets.only(left: 60, right: 10,),
            child: ReplyCard(
              replies: widget.replies
            ),
          ),
        ],
      ),
    );
    
  }
}



class NewsCard extends StatefulWidget {
  final String? id;
  final String bgImage;
  final String head;
  final String body;
  final String? startDate;
  final String? endDate;

  const NewsCard({
    Key? key,
    this.id,
    this.bgImage='',
    this.head='',
    this.body='',
    this.startDate,
    this.endDate

  }) : super(key: key);

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        
      },
      child: SizedBox(
        height: 180,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          //fit: StackFit.expand,
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CachedNetworkImage(
              imageUrl: widget.bgImage,
              fit: BoxFit.fill,

              placeholder: (Context, h){
                return CircularProgressIndicator();
              },
          ),

          //  Positioned(
          //    bottom: 5,
          //    child: Text(
          //      widget.head,
          //      textAlign: TextAlign.center,
          //      style: TextStyle(
         //         backgroundColor: Color.fromARGB(100, 177, 177, 177),
          //        color: cricGreen,
          //        fontSize: 20,
          //      ),
          //    ),
          //    )


          ],
        ),
          ),
      

    );
    
  }
}