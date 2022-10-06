// ignore_for_file: await_only_futures, unused_element, non_constant_identifier_names, unused_local_variable



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/utils/cards.dart';


class AwidsDB{

  final CollectionReference awidsCollection = FirebaseFirestore.instance.collection('devotionals');
  final CollectionReference devInsight = FirebaseFirestore.instance.collection('insights');
  final CollectionReference devLikes = FirebaseFirestore.instance.collection('likes');

  
  Future<void> like(devId)async{
    await devLikes.doc(devId).set(
      {
        'like_number':'0',
        'userId':'',
      }
    );
  }

  Future<void> addInsight(devId, title)async{
    await devInsight
    .doc(devId)
    .set(
      {
        'devId':devId,
        'name': title
      }
    );
  }

  Future addDev(
    id,
    String title,
    openScripture,
    passage,
    date,
    body,
    instruction,
    doWord,
    furtherScripture,
    dailyScripture,
    bg,
  ) async{
      await awidsCollection.doc(id).set({
        "id":id,
        "title":title,
        "passage":passage,
        "openingScripture":openScripture,
        "date":date,
        "body":body,
        "instruction":instruction,
        "doingTheWord":doWord,
        "furtherScripture":furtherScripture,
        "dailyScripture":dailyScripture,
        "bgImage":bg,
        'search_field':title.toLowerCase().split(' '),
        'views': 0
    });

    await like(id);
    await addInsight(id, title);

  }

  Future updateDev(Map<String, dynamic> data, id) async{
      await awidsCollection.doc(id).update(
        data
    );

  }

  Future<void> addView(id)async{
    final d = await awidsCollection.doc(id).get();
    final f = d.data() as Map<String, dynamic>;
    
    await updateDev({ 'views': f['views']+1 }, id);
  }


  Stream<QuerySnapshot> get getDevotionals{
    return awidsCollection.snapshots();
  }

  Future<QuerySnapshot> searchDevs(String q)async{
    final s = q.toLowerCase().split(' ');
    final res = await awidsCollection.where('search_field', arrayContainsAny: s).get();
    return res;
  }
}



class CricNewsDB{

  final CollectionReference newsCollection = FirebaseFirestore.instance.collection('news');

  Future addNews(
    String head,
    String body,
    int eventDate,
    String bgImage,
    int expDate,
    String id
    
  ) async{
      await newsCollection.doc(id).set({
        'id':id,
        "bgImage":bgImage,
        "head":head,
        "start":eventDate,
        "end":expDate,
        "body":body,
    });
  }

  Future updateDev(
    Map<String, dynamic> data,
    id
    ) async{
      await newsCollection.doc(id).update(
        data
    );

  }

  List<NewsCard> newsC(QuerySnapshot _news){
    return _news.docs.map((doc){
      final data = doc.data() as Map<String, dynamic>;
      return NewsCard(
        id: data['id']??'',
        bgImage: data['bgImage']??'',
        head: data['head']??'',
        startDate: data['start']??'',
        endDate: data['end']??'',
        body: data['body']??'',
        );
    }).toList();
  }

   Stream<List<NewsCard>> get getNews{
    return newsCollection.snapshots().map(newsC);
  }

  Stream<QuerySnapshot> get getNew{
    return newsCollection
    //.where('end', isLessThanOrEqualTo: DateTime.now())
    .snapshots();
  }

 // Future<QuerySnapshot> searchDevs(String q)async{
   // final s = q.toLowerCase().split(' ');
    //final res = await newsCollection.where('search_field', arrayContainsAny: s).get();
//    return res;
  //}



}






class AwidsInsight{

  String devId;

  AwidsInsight(
    this.devId
  );

  final CollectionReference devInsight = FirebaseFirestore.instance.collection('insights');

  final CollectionReference InsightLike = FirebaseFirestore.instance.collection('like_insight');
  //final CollectionReference InsightReply = FirebaseFirestore.instance.collection('reply_insight');


  Future<void> insightlike(iid)async{
    await InsightLike.doc(iid).set(
      {
        'like_number':'0',
        'userId':'',
      }
    );
  }


  Future<void> addInsight(
    insight,
    userId,
    devId,
    insightId,
    )async{

    await devInsight
      .doc(devId)
      .collection(devId)
      .doc(insightId)
      .set(
      {
        'insight':insight,
        'userId':userId,
        'devId': devId,
        'insightId':insightId,
      }
    );
  }

  Future<void> likeInsight(insightId, userId)async{
    DocumentSnapshot insight = await devInsight.doc(devId).collection(devId).doc(insightId).get();

    final d = insight.data() as Map<String, dynamic>;
    int n_like = int.parse(d['likes']) + 1;


    final doc = await devInsight.doc(devId).collection(devId).doc(insightId).update(
      {
        'likes': n_like.toString(),
      }
    );

  }


  List<InsightCard> insights(QuerySnapshot _insights){
    return _insights.docs.map((doc){
      final data = doc.data() as Map<String, dynamic>;
      return InsightCard(
        insight: data['insight']??'',
        insightId: data['insightId']??'',
        devId: data['devId']??'',
        insighterId: data['userId']??'',
        );
    }).toList();
  }

   Stream<List<InsightCard>> get getInsights{
    return devInsight.doc(devId).collection(devId).snapshots()
    .map(insights);
  }

  }


class AwidsLike{

  final CollectionReference devLikes = FirebaseFirestore.instance.collection('likes');

  bool liked = false;

  Future<bool> check_like(String userId, String devId)async{
    DocumentSnapshot d = await devLikes.doc(devId).get();

    final likes = d.data() as Map<String, dynamic>;
    final nl = int.parse(likes['like_number']);

    final String users = likes['userId'];

    if(users.isEmpty){
      return false;
    }

    final gUsers = users.split(' ');

    if(gUsers.length==1){
      if(gUsers[0]==userId){
        return true;
      }
      return false;
    }

    if(gUsers.length>1){
      for(var i in gUsers){
        if(i == userId){
          return true;
        }
      }
      
    }

    return false;
  }
  

  Future<bool> like(String userId, devId)async{

    DocumentSnapshot d = await devLikes.doc(devId).get();

    final likes = d.data() as Map<String, dynamic>;
    final nl = int.parse(likes['like_number']);

    bool hasLiked = await check_like(userId, devId);

    if(
      hasLiked == false
      ){
    await devLikes.doc(devId).update(
      {
        'like_number': (nl+1).toString(),
        'userId':"${likes['userId']} $userId",
      }
    );

    return true;

  }
  
    final likers = likes['userId'].split(' ');
    final l = likers.remove(userId);
    final String like = likers.join(' ');
    await devLikes.doc(devId).update(
      {
        'like_number': (nl-1).toString(),
        'userId': like,
      }
    );

    return false;
  
  }
  
  Future<int> getlike(String devId)async{

    DocumentSnapshot d = await devLikes.doc(devId).get();

    final likes = d.data() as Map<String, dynamic>;
    final nl = int.parse(likes['like_number']);

    return nl;
  }

  Stream<DocumentSnapshot> justLike(did){
    final doc = devLikes.doc(did).snapshots();
    return doc;
  }
  
  
  }




enum month  {
  January, February, March, April, May, June, July, August, September, October, November, December
}


class Monthly{
  final monthly = FirebaseFirestore.instance.collection('monthly');

  Future<void> creatMonth(id) async{
      await monthly.doc(id).set(
      {  
        'id':id,
        'img':'',
        'letter':'',
        'events':[]
      },
    );
    
  }


  Future<void> updateMonth(data, id) async{
    await monthly.doc(id).update(
        data 
    );
  }





  Future<void> themeImg(String imglink, id) async{
    updateMonth(
      {'img':imglink},
      id);
  }


  Future<void> monthlyLetter(String letter, id) async{

    final d = await getMonthData(id);
    String e = d!['letter'];
    
    
    await updateMonth(
      {'letter': '${e} **new** ${letter}'},
      id);

    }

  Future<void> addEvent(event, id) async{
   
    final d = await getMonthData(id);

    List e = d!['events'];
    e.add(event);

    await updateMonth(
      {
        'events':e
        },
      id);
  }

  Future<Map<String, dynamic>?> getMonthData(id) async{
    DocumentSnapshot month = await monthly.doc(id).get();

    final monthData = month.data() as Map<String, dynamic>;

    return monthData;

    
  }

}




class InsightLikeReply{

  final CollectionReference InsightLike = FirebaseFirestore.instance.collection('like_insight');
  //final CollectionReference InsightReply = FirebaseFirestore.instance.collection('reply_insight');

  bool liked = false;

  Future<bool> check_like(String userId, String iid)async{
    DocumentSnapshot d = await InsightLike.doc(iid).get();

    final likes = d.data() as Map<String, dynamic>;
    final nl = int.parse(likes['like_number']);

    final String users = likes['userId'];

    if(users.isEmpty){
      return false;
    }

    final gUsers = users.split(' ');

    if(gUsers.length==1){
      if(gUsers[0]==userId){
        return true;
      }
      return false;
    }

    if(gUsers.length>1){
      for(var i in gUsers){
        if(i == userId){
          return true;
        }
      }
      
    }

    return false;
  }
  

  Future<bool> like(String userId, iid)async{

    DocumentSnapshot d = await InsightLike.doc(iid).get();

    final likes = d.data() as Map<String, dynamic>;
    final nl = int.parse(likes['like_number']);

    bool hasLiked = await check_like(userId, iid);

    if(
      hasLiked == false
      ){
    await InsightLike.doc(iid).update(
      {
        'like_number': (nl+1).toString(),
        'userId':"${likes['userId']} $userId",
      }
    );

    return true;

  }
  
    final likers = likes['userId'].split(' ');
    final l = likers.remove(userId);
    final String like = likers.join(' ');
    await InsightLike.doc(iid).update(
      {
        'like_number': (nl-1).toString(),
        'userId': like,
      }
    );

    return false;
  
  }
  
  Future<int> getlike(String iid)async{

    DocumentSnapshot d = await InsightLike.doc(iid).get();

    final likes = d.data() as Map<String, dynamic>;
    final nl = int.parse(likes['like_number']);

    return nl;
  }

  Stream<DocumentSnapshot> justLike(iid){
    final doc = InsightLike.doc(iid).snapshots();
    return doc;
  }
  
  }

