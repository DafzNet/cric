// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/controller/account.dart';
import 'package:ecommerce/utils/colors.dart';
import 'package:ecommerce/views/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        initialData: null,
        value: AwidsAuth().userState,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '',
          theme: ThemeData(
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: bg_color,
            fontFamily: 'lato',
          ),
          home: ChoiceScreen(),
        ),
      );
    
  }
}