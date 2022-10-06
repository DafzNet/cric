import 'package:cloud_firestore/cloud_firestore.dart';

class CricUser{

  final CollectionReference cricUserCollection = FirebaseFirestore.instance.collection('users');

  final String uid;

  CricUser(
    this.uid,
  );


  Future createUser(
    name,
    phone,
    email,
    dp,
    gender,
    dob
  ) async{
      return await cricUserCollection.doc(uid).set({
        'name': name,
        'phone': phone,
        'email': email,
        'gender': gender,
        'dob':dob,
        'dp': dp,
        'starred':''
    });

  }

  Future<Map<String, dynamic>> getUser() async{
    DocumentSnapshot user = await cricUserCollection.doc(uid).get();

    final userData = user.data() as Map<String, dynamic>;

    return userData;
  }

  Future updateUser( Map<String, dynamic> data) async{
      await cricUserCollection.doc(uid).update(
        data
    );

  }



}