// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/account.dart';
import 'package:ecommerce/controller/storage.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/utils/profile_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileScreen extends StatefulWidget {

  final String uid;

  const ProfileScreen({Key? key,
  required this.uid,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final AwidsStorage storage = AwidsStorage();

  Future<void> signOut() async{
    AwidsAuth auth = AwidsAuth();
    await auth.signOut();
  }


  Map<String, dynamic>? userD;

  Future<void> profDetails() async{
    CricUser cric = CricUser(widget.uid);
    final user = await cric.getUser();
    setState(() {
      userD = user;
    });
  }


  Future<void> upDetails(Map<String, dynamic> data) async{
    CricUser cric = CricUser(widget.uid);
    await cric.updateUser(data);
  }



  @override
  void initState() {

    super.initState();
    profDetails();

  }




  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors


    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          onPressed:(){
            Navigator.of(context).pop();
          },

          icon: Icon(
            Icons.arrow_back_sharp,
            color: general_text_color,
          ),

       ),


        title: Text(
          'My Profile',
          style: TextStyle(
            color: general_text_color,
            fontSize: 22
          ),
        ),


        actions: [
          //signout here
          TextButton.icon(
            onPressed: () async{
              try{
                await signOut();
                Navigator.pop(context);
              }
              catch(e){return;}
              
            },
            
            icon: Icon(
              MdiIcons.logout,
              color: cricGreen,
            ),
            
            label: Text("sign out",

            style: TextStyle(
              fontSize: 18,
              color: cricGreen
            ),
            
            ))
        ],



        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              bg_deep,
              Colors.white,
              Colors.white,
              Colors.white,
             
            ],))
          ),     
        ),
        elevation: 0,
      ),



      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              bg_deep,
              Colors.white,
              Colors.white,
              Colors.white,
             
            ],
            
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width-150,
                            child: userD != null ? ClipOval(
                              
                              child: CachedNetworkImage(
                                imageUrl: userD!['dp'],
                                placeholder: (context, url)=>CircularProgressIndicator(),
                              ),
                              //Image.network(
                               // userD!['dp']
                             // ),
                            ):
                            CircularProgressIndicator.adaptive(),
                        ),
              
                        Positioned(
                          right: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              color: bg_deep,
                              borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            child: IconButton(
                              onPressed: (){
                                showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context){
                            return Container(
                              color: bg_color,
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () async{
      
                                      
                                      await storage.imgFromGallery();
      
                                      
                                      String dp = await storage.uploadFile(widget.uid);
                                      upDetails({'dp':dp});
                                      Navigator.of(context).pop();
                                      
                                    }, icon: Icon(
                                      MdiIcons.folderDownload,
                          
                                      size: 50,
                                      color: Color.fromARGB(255, 119, 90, 4),
                                    )
                                    ),
      
                                    SizedBox(width: 100,),
      
                                  IconButton(
                                    onPressed: () async{
      
                                      await storage.imgFromCamera();
                                      String dp = await storage.uploadFile(widget.uid);
                                      upDetails({'dp':dp});
                                      Navigator.of(context).pop();
                                    
                                      
      
                                    }, icon: Icon(
                                      MdiIcons.camera,
                                      size: 50,
                                      color: Color.fromARGB(255, 49, 48, 48),
                                    )
                                    )
                                ],
                              ),
                            );
                          }
                          );
                              },
                              icon: Icon(
                                Icons.camera_alt
                              )),
                          ),
                        )
              
              
                      ],
                    ),
                  ),
                )
              ),
      
              Divider(
                height: 10,
                thickness: 1,
              ),
              
              Flexible(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
              
                    children: [
                      ProfileText(
                        icon: MdiIcons.accountBoxOutline,
                        title: userD != null ? userD!['name'] : 'loading...',
                        opacity: true,
                        ),
              
                      ProfileText(
                        icon: MdiIcons.genderMaleFemaleVariant,
                        title: userD != null ? userD!['gender'] : 'loading...',
                        opacity: false,
                        ),
              
                      ProfileText(
                        icon: MdiIcons.email,
                        title: userD != null ? userD!['email'] : 'loading...',
                        opacity: false,
                        ),
              
                      ProfileText(
                        icon: MdiIcons.phone,
                        title: userD != null ? userD!['phone'] : 'loading...',
                        opacity: true,
                        ),
              
                      ProfileText(
                        icon: MdiIcons.calendarAlert,
                        opacity: false,
                        title: userD != null?
                            userD!['dob'].toString().isNotEmpty ? DateFormat.yMMMEd().format(DateTime.parse('${userD!['dob']}')) : ''
                          :'loading...'
                        
                        ),
      
                    ],
                  ),
                )
              ),
              
              
              
              
            ],
          ),
        ),
      )
    );
  }
}

