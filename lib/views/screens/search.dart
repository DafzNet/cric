// ignore_for_file: prefer_const_constructors, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/awids.dart';
import 'package:ecommerce/utils/cards.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {

  final String uid;


  const SearchPage({
    Key? key,
    required this.uid
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  AwidsDB db = AwidsDB();

  List<AwidsCard> searchResults = [];

  Future<void> search(String text) async {

    setState(
      (){
        searchResults=[
          AwidsCard(id: 's', uid: '')
        ];
      }
    );

    QuerySnapshot res = await db.searchDevs(text);



     final allDocs = await res.docs;

     List<AwidsCard> awidsList = [];

      for (var doc in allDocs) {
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
            views: data['views']??'',
        
          )
        );
      }

      awidsList.sort(
        (a,b)=>b.date.compareTo(a.date)
      );

      setState(() {
        if(awidsList.isNotEmpty)
          {searchResults = awidsList;}
        else{
          searchResults = [AwidsCard(id: 'n', uid: '')];
        }


      });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: bg_color,
            //pinned: true,
            snap: true,
            floating: true,

            automaticallyImplyLeading: false,
    

            expandedHeight: 80,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      
                    ),

                    Container(
                     // padding: EdgeInsets.all(12),
                      height: 50,
                      width: MediaQuery.of(context).size.width-(MediaQuery.of(context).size.width/9),
                      decoration: BoxDecoration(
                        color: bg_deep,
                        borderRadius: BorderRadius.all(Radius.circular(35))
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: IconButton(
                                onPressed: (){
                                   Navigator.of(context).pop();
                                },
                                icon: Icon(
                                        Icons.arrow_back,
                                        size: 25,
                                        color: general_text_color,
                                      ),
                                    ),
                            ),
                                ),

                          Flexible(
                            flex: 7,
                            child: TextFormField(

                              onFieldSubmitted: (value){
                                search(value);
                                },

                              textInputAction: TextInputAction.search,
                              autofocus: true,
                              style: TextStyle(
                                
                                fontSize: 18,
                              ),
                              decoration: InputDecoration.collapsed(
                                
                                border: InputBorder.none,
                                //icon: Icon(Icons.search),
                                //iconColor: general_text_color,
                                hintText: 'search by topic',
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          if(searchResults.isEmpty)
          ...[SliverToBoxAdapter(
            child: Center(
              child: Text('Your Search results will appear here'),
            ),
          )]
          else
          
           ...[
            
            if(searchResults[0].id=='s')
              ...[SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator())
                  )
                  )
                  ]

            else if(searchResults[0].id=='n')
              ...[SliverToBoxAdapter(
                child: Center(child: Text('Search ended with no Result',
                style: TextStyle(
                  fontSize: 18,
                ),
                )) )]

            else 
            ...[SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index){
                return AwidsCard(
                  uid: searchResults[index].uid,
                  id: searchResults[index].id,
                  title: searchResults[index].title,
                  body: searchResults[index].body,
                  date: searchResults[index].date,
                  dailyScripture: searchResults[index].dailyScripture,
                  doingTheWord: searchResults[index].doingTheWord,
                  bgImage: searchResults[index].bgImage,
                  instruction: searchResults[index].instruction,
                  furtherScripture: searchResults[index].furtherScripture,
                  openingScripture: searchResults[index].openingScripture,
                  passage:searchResults[index].passage,
                  views: searchResults[index].views,
                   );
              },

              childCount: searchResults.length,
              
              )
            )]
           ],


        ],
      ),
    );
  }
}
