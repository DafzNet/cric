import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/views/screens/home.dart';
import 'package:ecommerce/views/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/awids.dart';


class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return user == null ? const LoginScreen()
    :
    StreamProvider<QuerySnapshot?>.value(
      value: AwidsDB().getDevotionals,
      initialData: null,
      child: HomeScreen(uid: user.uid,),
      );
    
  }
}