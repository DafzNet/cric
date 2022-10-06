// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce/controller/account.dart';
import 'package:ecommerce/views/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../utils/utilities.dart';





class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String email = '';
  String pwd = '';


  bool loading = false;


  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                  child: Container(
                    
                  ),
                ),


                Column(
                  children: [

                    Opacity(
                      opacity: .9,
                      child: Image.asset("assets/images/cric.png",
                      width: width/4,
                      height: width/4,
                      ),
                    ),

                    SizedBox(
                      height: 20,
                      child: Container(
                    
                  ),
                ),


                  Text("Welcome!",
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      letterSpacing: 2
                    ),
                  ),

                  Text("we're glad you're here",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 2
                    ),
                  ),

                
                    SizedBox(
                      height: 30,
                      child: Container(
                    
                  ),
                ),
                
                    TextFormField(
                      controller: _emailController,                      
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: textInputDecorator('Email', MdiIcons.emailOutline),
                      onChanged: (value) {
                        email= value;
                      },
                    ),


                     SizedBox(
                      height: 20,
                    ),



                    TextFormField(
                      controller: _passController,
                    
                      obscureText: true,
                      style: TextStyle(
                        
                        fontSize: 20,
                      ),
                      decoration: textInputDecorator('Password', MdiIcons.keyOutline),
                      onChanged: (value) {
                        pwd = value;
                      },
                    ),


                    SizedBox(
                      height: 30,
                    ),


                    GestureDetector(
                      onTap: () async{
                        if(_emailController.text.isNotEmpty && _passController.text.isNotEmpty){
                        setState(() {
                          loading=true;
                        });

                        AwidsAuth user = AwidsAuth();
                        await user.signInEmailPassword(eml: email, psd: pwd);

                        setState(() {
                          loading=false;
                        });
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            messengerBar(context, msg: 'both fields are required')
                          );
                        }
                      },
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 100),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 58, 159, 127),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 45, 44, 44)
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic
                          ),
                          ),


                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                                return RegisterScreen();
                              }
                            ));
                          },

                          child: Text(
                            '  Register here!',
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                  
/*
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    SizedBox(
                      height: 30,
                    ),

                    Text('or continue with',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),

                    SizedBox(
                      height: 25,
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            
                          },
                          icon: Icon(
                            FontAwesomeIcons.facebook,
                            color: Color.fromARGB(255, 25, 99, 225),
                            size: 35,
                          ),
                        ),


                        SizedBox(
                      width: 25,
                    ),

                        IconButton(
                          onPressed: () {
                            
                          },
                          icon: Image.asset('assets/images/google.png')
                        )
                      ],
                    ),

                     SizedBox(
                        height: 205,
                      ),

                    
                  ],
                )
*/

                  SizedBox(
                        height: 355,
                      ),


              ],
            ),
          ),
        ),
      ), 
    );
  }

  InputDecoration textInputDecorator(String hint, IconData icon, {bool suf = false}) {
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
                          color: Color.fromARGB(255, 254, 254, 254),
                        ),
                        child: Icon(
                          icon,
                          color: Color.fromARGB(255, 76, 77, 77),
                        ),
                      )
                    );
  }
}