import 'package:ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';


class Statement extends StatefulWidget {



  const Statement({Key? key,

  }) : super(key: key);

  @override
  State<Statement> createState() => _StatementState();
}

class _StatementState extends State<Statement> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: DefaultTabController(
          length: 3,
            child: NestedScrollView(

              body: TabBarView(
                
                children: [

                  FaithStatement(),

                  CoreValues(),

                  NewCreation(),

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
                        'Faith Statement',

                        style: TextStyle(
                              fontSize: 16,
                              color: general_text_color,
                              fontWeight: FontWeight.bold
                            ),
                      )
                      ),
                    
                    Tab(
                      child: Text(
                        "Core Values",

                        style: TextStyle(
                              fontSize: 16,
                              color: general_text_color,
                              fontWeight: FontWeight.bold
                            ),
                  
                      ),
                    ),

                    Tab(
                      child: Text(
                        "New Creation Creed",

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

class FaithStatement extends StatelessWidget {
  const FaithStatement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
         top: 10,
         bottom: 15,
         left: 40,
         right: 30,
        ),
        child: Text(
          """
    1. That there is one God eternally existent as the Father, Son and the Holy Spirit (1 John 5:7, Matthew 28:19)
    
    2. That the Bible is the inerrant, infallible and authoritative Word of God given by the inspiration of the Holy Spirit. II Timothy 3:16, II Peter 1:20-21.
    
    3. That the Bible is the guidelines and rule-book for all faith and practice. II Timothy 3:16-17; James 1:21-25.
    
    4. We believe that Jesus Christ is the Son of God that He died for our sins, was buried for our sins and that He was raised from the dead on the third day according to the scriptures. 1 Corinthians 15:3-4, Luke 24:46, Romans 1:3-4.
    
    5. That Jesus Christ is the only way to salvation from sin and eternal damnation. Acts 4:12, Romans 10:13, John 14:6.
    
    6. In the new birth experience; that every one that believes that God raised Christ from the dead and confesses Him Lord is saved (born again) Romans 10:9-10; II Corinthians 5:17.
    
    7. In the enduement of the Holy Spirit called the baptism with the Holy Spirit with evidence of speaking with other tongues. Acts 2:4, 10:44-46.
    
    8. We believe in the gift of the Holy Spirit and exercise thereof. I Corinthains 12:1-11, 14:1)
    
    9. We that God still heals today and that the miracles in the life of Jesus Christ in the gospels and those done by the Apostles are to be perpetuated through us. John 14:12; Mark 16:17-18.
    
    10. We believe in the rapture of the Church. I Corinthians 15:51-52, I Thessalonians 4:16-17.
    
    11. We believe that as a Church we ought to demonstrate Christ-like love to one another and to the world. 1 John 4:7, John 15:12.
    
    12. We believe that every one of us should be involved in soul winning because Christ commands us to reach our world with the gospel. Matthew 28:18-20, Mark 16:15.
    """,
    
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 20,
            color: general_text_color,
            height: 2.4,
            wordSpacing: 2
          ),
        ),
      ),
    );
  }
}





class CoreValues extends StatelessWidget {
  const CoreValues({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
         top: 10,
         bottom: 15,
         left: 40,
         right: 30
    
        ),
        child: Text(
          """
          1. We are committed to teaching and preaching God’s word with Accuracy, Integrity and Authority so that unbelievers may find Christ and believers mature in Him (Acts 2:42, Eph. 4:11-16, Acts 6:2-4).
          
          2. We believe that prayer is vital to Christian ministry. Therefore, the ministry and activities of the church will be characterized by reliance on personal and corporate prayer (Ephesians 6:18-20; 1:6, Acts 6:2, 4:6. Romans 15:30-31, Colossians 4:2-4). we believe that every Christian is called to pray (1Timothy 2:8, Luke 18:1).
    
          3. We believe that all activities and ministry of this Church should be done according to the leading, guidance, direction and leadership of the Holy Spirit (Acts 1:2, 4:19-20, 10:19-20, 13:2-4, 15:28).
    
          4. We believe that primary responsibility of Pastors and Teachers in the Local Church is to prepare God’s people for works of service and to motivate them toward evangelism (Ephesians 4:11-12, 2Corinthians 5:18). Therefore, all members are trained to participate actively in ministry (Ephesians 4:11-16.).
    
          5. We believe that as children of God, it is our responsibility to communicate the love of God to ne another through mutual fellowship, small groups, giving and caring for one another and for those outside the church (Acts 2:44-45, 4:32-37). We believe giving is an expression of our love life. We consider it a part of our calling to lovingly respond to the needs of others. We are called to take the love of God to every individual.
    
          6. We believe in evangelism (Matthew 28:19-20, Mark 16:15, 2Corinthians 15:18, Acts 8:4, Mark 16:20) We also believe it is our sacred responsibility to reach the world with the Word of God. We will actively pursue means, methods and strategies that will enhance and facilitate our effort towards evangelism.
          """,
    
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 20,
            color: general_text_color,
            height: 2.4,
            wordSpacing: 2
          ),
        ),
      ),
    );
  }
}




class NewCreation extends StatelessWidget {
  const NewCreation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
         top: 10,
         bottom: 15,
         left: 40,
         right: 30
    
        ),
        child: Text(
          """
    I Belong to NEW ORDER
    God’s NEW RACE the Church
    I am a NEW CREATION in Christ Jesus
    Who LOVED ME and gave HIMSELF for me
    I’ve been DELIVERED from the power of darkness
    and translated into the kingdom of God’s dear Son
    I am the RIGHTEOUSNESS of God in Christ Jesus
    I am FREE from the LAW OF SIN and DEATH,
    I have the LOVE OF GOD abounding in MY HEART in a greater measure
    The POWER and ABILITY of GOD are at work within me and through me
    I have a SOUND MIND, the MIND OF CHRIST
    MENTAL SAGACITY that surpasses Human intelligence
    ETERNAL LIFE has permeated my being
    I live in DIVINE HEALTH for by HIS STRIPES I WAS HEALED
    God is causing all GRACE, every FAVOUR and all EARTHLY BLESSINGS to come to me in abundance
    I have VICTORY over satan, sin, sickness, weakness , disease, fear, death and hell
    I’m a joint heir with Jesus, seated in heavenly places in Christ Jesus
    I am God’s point of contact to my world,
    Declaring God’s love plan to all men
    Persuading them to come and enjoy the benefits of the NEW CREATION life in Christ Jesus.
          """,
    
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 20,
            color: general_text_color,
            height: 2.4,
            wordSpacing: 2
          ),
        ),
      ),
    );
  }
}