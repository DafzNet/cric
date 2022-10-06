
// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'dart:io';

import 'package:ecommerce/controller/storage.dart';
import 'package:ecommerce/models/awids.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'devotional/component.dart';

class CricNews extends StatefulWidget {
  const CricNews({Key? key}) : super(key: key);

  @override
  State<CricNews> createState() => _CricNewsState();
}

class _CricNewsState extends State<CricNews> {


  final AwidsStorage storage = AwidsStorage();


  final titleController = TextEditingController();
  final bodyController = TextEditingController();

   final titleNode = FocusNode();



final _initialDate = DateTime.now();

int start=DateTime.now().millisecondsSinceEpoch;
int end = DateTime.now().millisecondsSinceEpoch;
File? img;


String id = '';



void create(){
  setState(() {
    id = DateTime.now().microsecondsSinceEpoch.toString();
  });
  
}


String? download;

Future<void> submit()async{
  final download = await storage.uploadFile(id, dest: 'news');
  await CricNewsDB().addNews(
    titleController.text,
    bodyController.text, 
    start,
    download,
    end, 
    id);


}






  
Future<DateTime> pickDate(DateTime curDate) async{
  final DateTime? _pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: _initialDate,
                                      firstDate: DateTime.now().subtract(Duration(days: 1095)),
                                      lastDate: DateTime.now().add(Duration(days: 1095)),
                                    );

       if (_pickedDate != null) {
              curDate = DateTime(
              _pickedDate.year,
              _pickedDate.month,
              _pickedDate.day,
              _initialDate.hour,
              _initialDate.minute,
              _initialDate.second,
              _initialDate.millisecond,
              _initialDate.microsecond);
            }

        return curDate;
}

bool loading = false;

@override
  void initState() {
    create();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Add News',
          style:  TextStyle(
            color: bg_deep,
          ),
        ),
        backgroundColor: bg_color,
        elevation: 0,
      ),

      body: loading ==true?
      Center(
        child: Column(
          children: [
            SizedBox(height: 100,),
            
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator()),
          ],
        ),
      )
      : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              DevSingleTextField(
                textController: titleController,
                focusNode: titleNode,

                multLine: false,

                head: 'Head',
                hintT: 'heading/topic',
              ),
              /////////////////////////////
              
               DevMultTextField(
                textController: bodyController,
                head: 'Body',
                hintT: ''
                ),

              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: ()async{
                      final pick = await pickDate(_initialDate);
                      setState(() {
                        start = pick.millisecondsSinceEpoch; //pick;
                      });
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined
                    ), label: Text('Start: ${DateFormat.yMEd().format(
                      DateTime.fromMillisecondsSinceEpoch(start)
                      )}')),

                   TextButton.icon(
                    onPressed: ()async{
                      final pick = await pickDate(_initialDate);
                      setState(() {
                        end = pick.millisecondsSinceEpoch;
                      });
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined
                    ), label:  Text('End: ${DateFormat.yMEd().format(
                      DateTime.fromMillisecondsSinceEpoch(end)
                      
                      )}')),
                ],
              ),


              SizedBox(
                height: 10,
              ),


              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child:img != null? Image.file(
                      img!,
                      width: MediaQuery.of(context).size.width/2,
                    ):
                    Container(),
                  ),

                  SizedBox(width: 10,),

                  TextButton.icon(
                    onPressed: () async {
                     final im = await storage.imgFromGallery(quality: 80, crop: false);
                     setState(() {
                       img = im;
                     });
                    }, icon: Icon(
                      Icons.image,
                    ), label:Text('add image'))
                ],
              ),


              SizedBox(height: 10,),


              TextButton(
                onPressed:()async{
                  if(img != null){
                    setState(() {
                      loading=true;
                    });
                    await submit();
                    setState(() {
                      loading=false;
                    });
                  }
                  else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          snackBar(context),
                        );
                  }
              },
              
              child: Text('Submit'))
             


              
            ],
          ),
        )
        ),
      

    );
    
  }

  SnackBar snackBar(BuildContext context) {
    return SnackBar(
                         
                          content: const Text('image is required',
                          style: TextStyle(
                            color: Colors.white
                            ),
                          ),
                          duration: const Duration(milliseconds: 1500),
                          width: MediaQuery.of(context).size.width-50,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, // Inner padding for SnackBar content.
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: cricGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        );
  }
}