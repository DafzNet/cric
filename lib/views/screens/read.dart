// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, await_only_futures, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/awids.dart';
import 'package:ecommerce/utils/cards.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';



class ReadDev extends StatefulWidget {

  final String userId;
  final String devId;
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

  final String likes;
  const ReadDev({
    Key? key,
    required this.userId,
    required this.devId,
    required this.title,
    required this.body,
    this.passage = '',
    this.openingScripture = '',
    this.date = '',
    this.instruction = '',
    this.doingTheWord = '',
    this.furtherScripture = '',
    this.dailyScripture = '',
    this.bgImage = '',
    this.likes='',

    }) : super(key: key);

  @override
  State<ReadDev> createState() => _ReadDevState();
}

class _ReadDevState extends State<ReadDev> {


  final likes = AwidsLike();

  bool i_like=false;


  Future<void> iLike()async{
    bool l = await likes.check_like(widget.userId, widget.devId);
    setState(() {
      i_like=l;
    });
  }

  Future<void> like()async{
    bool k = await likes.like(widget.userId, widget.devId);
    setState(() {
      i_like=k;
    });
  }


  Future<void> _share()async{
    await Share.shareWithResult(
      'A Word In Due Season\nBy Apostle David Wale Feso \n\nTopic: ${widget.title}\n${DateFormat.yMMMEd().format(DateTime.parse(widget.date))}\n\nOpening Scripture: ${widget.passage}\n${widget.openingScripture}\n\n${widget.body}\n\nInstruction: \n${widget.instruction}\n\nFurther study: \n${widget.furtherScripture}\n\nDoing the Word: \n${widget.doingTheWord}\n\nDaily scripture reading: \n${widget.dailyScripture}',
      subject: widget.title
    );
  }



  @override
  void initState() {
    iLike();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      body: CustomScrollView(
        
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
    
            leadingWidth: 30,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
    
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: headerFontSize,
                color: Colors.black,
                fontWeight: FontWeight.bold
    
              ),
              ),
    
            backgroundColor: bg_color,
            pinned: true,
            expandedHeight: widget.bgImage.isNotEmpty? 250 : 0,
            flexibleSpace: FlexibleSpaceBar(
    
    
    
              background: widget.bgImage.isNotEmpty? 
                  CachedNetworkImage(
                        imageUrl: widget.bgImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url)=>
                            Container()
                        )
                        :
                        Container()
    
    
            ),
          ),
    
          
    
           SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10,),
              child: Column(
                children: [
                  
              
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom:15, left: 20, right: 20),

                    child: Text(
                      '${widget.passage}\n${widget.openingScripture}',
                      textAlign: TextAlign.center,
                      softWrap: true,
                                        
                      style: TextStyle(
                        height: 2,
                        fontSize: 20,
                        wordSpacing: 2,
                        color: Color.fromARGB(255, 45, 3, 194)
                      ),
                    ),
                  ),
                  ///////////////////////////////////////
                  Text(
                    widget.body,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.7,
                      fontSize: defaultFontSize,
                      wordSpacing: 2,
                    ),
                  ),
                
                ///////////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Instruction',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.7,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                
                  Text(
                    widget.instruction,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.7,
                      fontSize: defaultFontSize,
                      wordSpacing: 2,
                    ),
                  ),
                ///////////////////////////////////////////////////////////
                ///////////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Further Study',
                      textAlign: TextAlign.center,
                
                      style: TextStyle(
                        height: 1.7,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                
                  Text(
                    widget.furtherScripture,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.7,
                      fontSize: defaultFontSize,
                      wordSpacing: 2,
                    ),
                  ),
                ///////////////////////////////////////////////////////////
                ///////////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Doing  The Word',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.7,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                
                  Text(
                    widget.doingTheWord,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.7,
                      fontSize: defaultFontSize,
                      wordSpacing: 2,
                    ),
                  ),
                ///////////////////////////////////////////////////////////
                ///////////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Daily Scripture Reading',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.7,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                
                  Text(
                    widget.dailyScripture,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.7,
                      fontSize: defaultFontSize,
                      wordSpacing: 2,
                    ),
                  ),
                ///////////////////////////////////////////////////////////
                
                
                
                
                  SizedBox(
                    height: 80,
                  )
                
                ],
              ),
            ),
          ),
        ],
      ),

  

      bottomNavigationBar: SizedBox(
        height: 50,

        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [

            //Like Button
            TextButton.icon(
              onPressed: () async{
                await like();
              },

              icon: Icon(
                Icons.thumb_up,
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




//Comment
            IconButton(
              onPressed: () async{
                await ShowComments(context);
              },
              icon: Icon(
                FontAwesomeIcons.comment,
                color: cricGreen,
                 ),
            ),








//share
            IconButton(
              onPressed: () async{
               await _share();
              },
              icon: Icon(
                Icons.share,
                color: cricGreen,
                 ),
            )


          ]),
      ),





    );
  }

  ShowComments(BuildContext context) async {
    showModalBottomSheet(
                                    
        isScrollControlled: true,

        backgroundColor: Colors.transparent,
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
        ),
        
        context: context,
        builder: (context){
          return ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            
              child: Container(
                    color: bg_color,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+5, top: 30),
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            top: 0,
                            
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(widget.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: headerFontSize,
                                      fontWeight: FontWeight.bold
                    
                                    ),
                                    ),
                                  ),
                    
                    
                                  IconButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                           }, 
                          icon: Icon(Icons.cancel_outlined,
                          color: Colors.redAccent,)
                        )
                    
                    
                        ],
                      ),
                                                       
                    ),
                    
                    Comment(widget: widget,),
                    
                    Positioned(
                    bottom: 5,
                    child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width-(MediaQuery.of(context).size.width/10),
                          decoration: BoxDecoration(
                          color: Color.fromARGB(179, 215, 220, 218),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                             ),
                             child: Padding(
                               padding: const EdgeInsets.only(left: 15),
                               child: TextFormField(
                    
                                  onFieldSubmitted: (value) async{
                                    await AwidsInsight(widget.devId).addInsight(
                                      value,
                                      widget.userId,
                                      widget.devId,
                                      '${DateTime.now().millisecondsSinceEpoch}'
                                    );
                                  },
                    
                                                          
                    
                                 style: TextStyle(
                                                                                 
                                   fontSize: 18,
                                 ),
                                 decoration: InputDecoration(
                                   border: InputBorder.none,
                                   icon: Icon(
                                    FontAwesomeIcons.comment,
                                    color: cricGreen,
                                    ),
                                   iconColor: general_text_color,
                                   hintText: 'share your insights',
                                 ),
                               ),
                             ),
                            ),
                         )
                        ],
                      ),
                    ),
                  ),
            
          );
           
        }
      );
  }
}









class Comment extends StatelessWidget {

  const Comment({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ReadDev widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60, top: 50),
      child: StreamProvider<List<InsightCard>>(
        create: (context)=>AwidsInsight(widget.devId).getInsights,
        initialData: [],
        child: CommentView(
          devId: widget.devId,
        ),
      ),
    );
  }
}

class CommentView extends StatefulWidget {
  
  final devId;
  const CommentView(
    {
    Key? key,
    required this.devId
  }) : super(key: key);

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {

  @override
  Widget build(BuildContext context) {



    final comments = context.watch<List<InsightCard>>();

      return ListView.builder(
          itemCount: comments.length,
    
          itemBuilder: (ctx, index){
            
            return InsightCard(
            
            insight: comments[index].insight,
            devId: comments[index].devId,
            insighterId: comments[index].insighterId,
            insightId: comments[index].insightId,
          );
        }
         
        );
    
  }
}




