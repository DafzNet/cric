// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, await_only_futures, use_build_context_synchronously, avoid_returning_null_for_void

import 'dart:io';

import 'package:ecommerce/controller/account.dart';
import 'package:ecommerce/controller/storage.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';




class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();



DateTime _initialDate = DateTime.now();

Future<DateTime> pickDate(DateTime curDate) async{
  final DateTime? _pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: _initialDate,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
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
        setState(() {
          _initialDate=curDate;
          dob = curDate.toString();
        });
        return curDate;
}


  final AwidsStorage storage = AwidsStorage();


  final  emailController = TextEditingController();
  final  passController = TextEditingController();
  final  nameController = TextEditingController();
  final  phoneController = TextEditingController();


  File? dpd = null;


  String email='';
  String password='';
  String name='';
  String phone='';
  String dp = '';
  String gender = 'male';
  String dob='';

  

  dynamic error = "";
  
  final AwidsAuth _currentUser = AwidsAuth();
  

  bool loading=false;


  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;



    return Scaffold(
      body: loading==true?
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
        child: Container(
          padding: EdgeInsets.all(30),
          color: Color.fromARGB(255, 5, 110, 59),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40,
                ),

                Column(
                  children: [

                    Stack(
                      alignment: Alignment.bottomRight,
                      
                      children: [
                        Opacity(
                          opacity: .9,
                          child: ClipOval(
                            child: dpd != null?
                              Image.file(dpd!,
                               width: width/3,
                            height: width/3,
                              
                              )  :
                              Image.asset("assets/images/avatar.png",
                            width: width/3,
                            height: width/3,
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                          onPressed: (){
                            imgUpload(context);
                          }, 
                            icon: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: bg_color,
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Icon(MdiIcons.camera,
                              color: bg_deep,
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),

                  Text("\nRegister with E-mail to get Started",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      letterSpacing: 2
                    ),
                  ),


                     SizedBox(
                  height: 20,
                ),


                    TextFormField(

                      controller: nameController,
                      
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: textInputDecorator('Full Name', MdiIcons.accountCircle),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),



                    SizedBox(
                      height: 20,
                    ),


                    TextFormField(
                      controller: phoneController,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: textInputDecorator('Phone', MdiIcons.phone),
                      onChanged: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                    ),


                     SizedBox(
                      height: 20,
                    ),


                    TextFormField(
                      controller: emailController,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: textInputDecorator('Email', MdiIcons.emailOutline),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),


                    TextFormField(
                      controller: passController,
                      obscureText: true,
                      style: TextStyle(
                        
                        fontSize: 20,
                      ),
                      decoration: textInputDecorator('Password', MdiIcons.keyOutline),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),


                    SizedBox(
                      height: 20,
                    ),


                    Row(
                      children: [
                        Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: Icon(
                          MdiIcons.genderMaleFemale,
                          color: Color.fromARGB(255, 45, 44, 44),
                          ),
                        ),

                        SizedBox(
                          width: 20,
                        ), 

                        ToggleSwitch(
                          minWidth: 100,
                          minHeight: 45,
                          initialLabelIndex: 0,
                          cornerRadius: 20,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,

                          totalSwitches: 2,

                          labels: ['Male', 'Female'],
                          icons: [MdiIcons.genderMale, MdiIcons.genderFemale],


                          onToggle: (idx){
                            idx == 0 ? gender = 'male' : gender='female';
                          },


                        ),
                      ],
                    ),


                     SizedBox(
                      height: 4,
                    ),

                    TextButton.icon(
                      onPressed: (){
                        pickDate(_initialDate);
                      }, 
                      icon: Icon(MdiIcons.calendar,
                      color: Colors.white
                      ), 
                      label: Text(
                        'DoB: ${DateFormat.yMMMEd().format(DateTime.parse('$_initialDate'))}',
                        style: TextStyle(
                          color: Colors.white
                        )
                        )
                        ),

                     SizedBox(
                      height: 4,
                    ),


                   TextButton(
                    onPressed: () async{

                      if(nameController.text.length < 5){
                        ScaffoldMessenger.of(context).showSnackBar(
                          messengerBar(context, msg: 'full name is required')
                        );
                      }

                      else if(passController.text.length < 6){
                        ScaffoldMessenger.of(context).showSnackBar(
                          messengerBar(context, msg: 'password length at least 6')
                        );
                      }

                      else if(emailController.text.length < 6){
                        ScaffoldMessenger.of(context).showSnackBar(
                          messengerBar(context, msg: 'Invalid email address')
                        );
                      }

                      else if(phoneController.text.length < 11 ){
                        ScaffoldMessenger.of(context).showSnackBar(
                          messengerBar(context, msg: 'at least 11 digits required for phone')
                        );
                      }

                      else if(dpd == null){
                        ScaffoldMessenger.of(context).showSnackBar(
                          messengerBar(context, msg: 'DP please, we would love to know you!')
                        );
                      }

                      else if(dob.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                          messengerBar(context, msg: 'Please include Date of birth')
                        );
                      }

                      else{
                      setState(() {
                        loading=true;
                      });
                      dynamic userCur = await _currentUser.registerUsingEmailPassword(eml: email.trim(), psd: password.trim());
                      
                      String userID = userCur.uid;

                      CricUser _user = CricUser(userID);

                      dp = await storage.uploadFile(userID);

                      await _user.createUser( name, phone, email, dp, gender, dob);
                      
                      

                      setState(() {
                        loading=false;
                      });
                      
                      
                      Navigator.pop(context);
                      
                      
                      }



                    },
                    
                    child: SizedBox(
                      width: 250,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          color: Color.fromARGB(255, 58, 159, 127),
                          child: Center(
                            child: Text('Register',
                            style: TextStyle(
                              color: Color.fromARGB(255, 45, 44, 44),
                              fontSize: 20
                            ),
                            )
                            )
                        )
                        ),
                    )
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic
                          ),
                          ),


                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            ' Login here!',
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),

                SizedBox(
                  height: 200,
                )
              ],  
            ),
          ),
        ),
      ), 
    );
  }

  Future<dynamic> imgUpload(BuildContext context) {
    return showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context){
                          return Container(
                            color: Color.fromARGB(244, 207, 247, 229),
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: ()async{
                                    final dpx = await storage.imgFromGallery();
                                    setState(() {
                                      dpd = dpx;
                                    });
                                    
                                    Navigator.of(context).pop();
                                  }, icon: Icon(
                                    MdiIcons.folderDownload,
                        
                                    size: 50,
                                    color: Color.fromARGB(255, 119, 90, 4),
                                  )
                                  ),

                                  SizedBox(width: 100,),

                                IconButton(
                                  onPressed: ()async{

                                    final dpx = await storage.imgFromCamera();
                                    setState(() {
                                      dpd = dpx;
                                    });
                                  
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
  }

  InputDecoration textInputDecorator(String hint, IconData icon) {
    return InputDecoration(
                      hintText: hint,
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      
                      
                      icon: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                          color: Color.fromARGB(255, 254, 255, 255),
                        ),
                        child: Icon(
                          icon,
                          color: Color.fromARGB(255, 45, 44, 44),
                        ),
                      )
                    );
  }
}