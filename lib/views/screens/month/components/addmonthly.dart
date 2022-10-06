
// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors
import 'dart:io';

import 'package:ecommerce/controller/storage.dart';
import 'package:ecommerce/models/awids.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/views/screens/home.dart';
import 'package:flutter/material.dart';

import '../../devotional/component.dart';


class MonthData extends StatefulWidget {
  const MonthData({Key? key}) : super(key: key);

  @override
  State<MonthData> createState() => _MonthDataState();
}

class _MonthDataState extends State<MonthData> {


  final AwidsStorage storage = AwidsStorage();

  final Monthly _monthObj = Monthly(); 


  final letterController = TextEditingController();
  final eventTitleController = TextEditingController();
  final eventDescController = TextEditingController();


final _initialDate = DateTime.now();

String id = '';
DateTime? idDate = DateTime.now();

DateTime? e = null;

String monthThemeImgUrl = '';

String letter = '';

File? img=null;

bool loading = false;




void createId(DateTime d){
  setState(() {
    id = '${d.month}_${d.year}';
  });
  
}



Future<void> submit()async{
    setState(() {
      loading = true;
    });


    createId(idDate!);


///////upload event
   if(eventTitleController.text.isNotEmpty && e != null){
      final ev = {
        'title': eventTitleController.text,
        'date': e.toString(),
        'desc':eventDescController.text
      };

    await _monthObj.addEvent(ev, id);
    }


    if(img != null){
      monthThemeImgUrl = await storage.uploadFile(id, dest: 'monthly theme');
      await _monthObj.themeImg(monthThemeImgUrl, id);
    }


    if(letterController.text.length>=50){
      String leta = letterController.text;
      await _monthObj.monthlyLetter(leta, id);
    }
    

  setState(() {
      loading = false;
    });
}


  
Future<DateTime?> pickDate({bool showTime=false}) async{

  TimeOfDay? _time = TimeOfDay.now();
  DateTime curDate = DateTime.now();
  final DateTime? _pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: _initialDate,
                                      firstDate: DateTime.now().subtract(Duration(days: 1095)),
                                      lastDate: DateTime.now().add(Duration(days: 1095)),
                                    );


                  
                  if (showTime==true)
                  {
                    final TimeOfDay? _pickedTime = await showTimePicker(
                                      context: context, 
                                      initialTime: TimeOfDay.now()
                                      );
                    _time = _pickedTime;
                            }        

       if (_pickedDate != null) {
              curDate = DateTime(
              _pickedDate.year,
              _pickedDate.month,
              _pickedDate.day,
              _time!.hour,
              _time.minute,
              _initialDate.second,
              _initialDate.millisecond,
              _initialDate.microsecond);
            }

        return curDate;
}


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Monthly Data',
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
      :
       SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              /////////////////////////////////////////////////////////////

              TextButton.icon(

                onPressed: ()async{
                  final _date = await pickDate();
                  if(_date != null){
                      idDate = _date;
                    }

                },

                icon: Icon(
                  Icons.calendar_today
                ),

                label: Text(
                  'Select Month, first day and year'
                ),

                ),

                ///////////////////////////////////////////////////////////
                
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 15),
                  child: DevMultTextField(head: 'Letter', hintT: 'monthly letter', textController: letterController),
                ),

                
                ////////////////////////////////////////////////////////
                Outliner(outline: 'Add Upcoming event'),

                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DevSingleTextField(
                        head: 'title',
                        hintT: 'Event title',
                        textController: eventTitleController),
                      
                      DevMultTextField(head: 'Description', hintT: 'What is it about', textController: eventDescController),

                      TextButton.icon(
                        onPressed: ()async{
                          final _edate = await pickDate(showTime: true);
                          if(_edate != null){
                            setState(() {
                              e = _edate;
                            });
                          }
                        }, 
                        icon: Icon(
                          Icons.calendar_today
                        ), 
                        label: Text('Select Event date and time'))
                    ],
                  ),
                ),


//////////////////////////////////////////////////////////////////////////
                Outliner(outline: 
                'Upload monthly theme'
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: img != null? Image.file(
                        img!,
                        width: MediaQuery.of(context).size.width/2,
                      ):
                      Container(),
                    ),

                    SizedBox(width: 10,),

                    TextButton.icon(
                      onPressed: () async {
                       final im = await storage.imgFromGallery(quality: 60, crop: false);
                       setState(() {
                         img = im;
                       });
                      }, icon: Icon(
                        Icons.image,
                      ), label:Text('Upload theme'))
                  ],
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 30,),

                  TextButton(onPressed: ()async{

                    showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(10)
                            )
                            ),


                          title: Text('Upload Monthly Data?'),
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text("Selected month ${['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'].elementAt(idDate!.month-1)}, ${idDate!.year}")
                            ),

                          actions: [
                            TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },

                              child: Text("Continue Editing",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: cricGreen
                                ),
                              )
                              ),
                        
                            TextButton(
                              onPressed: ()async{
                                Navigator.of(context).pop();
                                
                                await submit(); 
                              },

                              child: Text("Continue Uploading",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )
                              )
                          ],
                        );
                      }
                    );


                  }, child: Text('Add monthly Data'))
                ],
              )
                
            ],
          ),
        )
        ),
      

    );
    
  }
}