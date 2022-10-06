// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:ecommerce/models/awids.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/views/screens/devotional/component.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../controller/storage.dart';



class AddAwidsScreen extends StatefulWidget {
  const AddAwidsScreen({Key? key}) : super(key: key);

  @override
  State<AddAwidsScreen> createState() => _AddAwidsScreenState();
}

class _AddAwidsScreenState extends State<AddAwidsScreen> {

  final AwidsStorage storage = AwidsStorage();

  final awidsdb = AwidsDB();

  final titleController = TextEditingController();
  final passageController = TextEditingController();
  final sriptureController = TextEditingController();
  final instructionController = TextEditingController();
  final furtherStudyController = TextEditingController();
  final doingController = TextEditingController();
  final dailyStudyController = TextEditingController();
  final bodyController = TextEditingController();


  final titleNode = FocusNode();
  final passageNode = FocusNode();
  final sriptureNode = FocusNode();
  final instructionNode = FocusNode();
  final furtherStudyNode = FocusNode();
  final doingNode = FocusNode();
  final dailyStudyNode = FocusNode();


  String devDate = '';
  String bg='';
  final DateTime _initialDate = DateTime.now();

  String devotionalId="";
  

  void getId(){
    devotionalId = DateTime.now().millisecondsSinceEpoch.toString();
  }




  Future<void> submitted(id) async{

    if(titleController.text.isNotEmpty){
      if(passageController.text.isNotEmpty){
        if(sriptureController.text.isNotEmpty){
          if(instructionController.text.isNotEmpty){
            if(furtherStudyController.text.isNotEmpty){
              if(doingController.text.isNotEmpty){
                if(dailyStudyController.text.isNotEmpty){
                  if(bodyController.text.isNotEmpty){

                    await awidsdb.addDev(
                        id,
                        titleController.text,
                        sriptureController.text,
                        passageController.text,
                        devDate, 
                        bodyController.text, 
                        instructionController.text, 
                        doingController.text, 
                        furtherStudyController.text,
                        dailyStudyController.text,
                        bg,

                      );
                  }
                }
              }
            }
          }
        }
      }
    }

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



void devDateFormat(DateTime date){
  final format = date.toString();
  
  setState(() {
    devDate = format;
    
  });
}


bool loading=false;

@override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    devDateFormat(DateTime.now());
    getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: bg_color,

        leading: Icon(
          MdiIcons.noteEdit,
          color: cricGreen,
        ),

        leadingWidth: 30,

        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            
            icon: Icon(
          Icons.cancel_outlined,
          color: Colors.red,
        ),
            
            )
        ],

        title: Text(
          'Add Devotional',
          style: TextStyle(
                    color: Colors.black,
                  ),
        ),


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
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 7,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(
                      Icons.calendar_today,
                      size: 28,
                      color: cricGreen,
                    ),
            
                  TextButton(
                    onPressed: () async{
                      devDateFormat(
                        await pickDate(_initialDate)
                      );
                    }
                    , 
                    child: Text(
                     DateFormat.yMMMEd().format(DateTime.parse(devDate)),
            
                    style: TextStyle(
                      fontSize: 20,
                      color: cricGreen
                    ),
            
            
                    )),
            
                    Icon(
                      Icons.arrow_drop_down,
                      size: 32,
                      color: cricGreen,
                    )
                ],
              ),
            ),


            DevSingleTextField(
              textController: titleController,
              focusNode: titleNode,
              nextNode: passageNode,

              multLine: false,

              head: 'Title',
              hintT: 'Devotional title',
            ),





            DevSingleTextField(
              textController: passageController,
              focusNode: passageNode,
              nextNode: sriptureNode,

              head: 'Passage',
              hintT: 'Scripture text',
            ),





            DevSingleTextField(
              textController: sriptureController,
              focusNode: sriptureNode,
              nextNode: instructionNode,

              multLine: false,

              head: 'Scripture',
              hintT: 'Bible verse',
            ),


            DevSingleTextField(
              textController: instructionController,
              focusNode: instructionNode,
              nextNode: furtherStudyNode,

              head: 'Instruction',
              hintT: 'Instruction',
            ),

            DevSingleTextField(
              textController: furtherStudyController,
              focusNode: furtherStudyNode,
              nextNode: doingNode,

              head: 'Further Study',
              hintT: 'Further study scriptures',
            ),

            DevSingleTextField(
              textController: doingController,
              focusNode: doingNode,
              nextNode: dailyStudyNode,

              head: 'Doing',
              hintT: 'Doing the word',
            ),

            DevSingleTextField(
              textController: dailyStudyController,
              focusNode: dailyStudyNode,
              nextNode: sriptureNode,

              head: 'Daily Study',
              hintT: 'Daily Scripture reading',
            ),



            DevMultTextField(
              textController: bodyController,
              head: 'Body',
              hintT: ''
              ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton.icon(
                onPressed: ()async{
                  
                                    await storage.imgFromGallery(quality: 70, crop: false);
                }, 
                icon: Icon(Icons.image), 
                label: Text('Upload header/use default')
                ),
            ),
            

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, 
                  
                  child: Text("Cancel",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  )
                ),

                

                TextButton(
                  onPressed: () {

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


                          title: Text('Sure'),
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text("Add devotional to database?")
                            ),

                          actions: [
                            TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },

                              child: Text("Cancel",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.red
                                ),
                              )
                              ),
                        
                            TextButton(
                              onPressed: ()async{
                                Navigator.of(context).pop();
                                setState(() {
                                  loading=true;

                                });
                                String dp = await storage.uploadFile(devotionalId, dest: 'AWIDS_bgs');
                                    setState(() {
                                      bg = dp;
                                    });
                                await submitted(devotionalId); 
                                setState(() {
                                  loading=false;

                                });
                              },

                              child: Text("Continue",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )
                              )
                          ],
                        );
                      }
                    );
                    
                  }, 

                  
                  child:Text("Add",
                    style: TextStyle(
                      fontSize: 18,
                      color: cricGreen
                    ),
                  )
                )
              ]
            )


          ],
        ),
        ),
    );
  }
}