
// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';


class AwidsAuth {

  FirebaseAuth auth = FirebaseAuth.instance;

  ///Firebase auth streams
  Stream<User?> get userState{
    return auth.authStateChanges();
  }

  Future<User?> registerUsingEmailPassword({
    required String eml,
    required String psd,
  }) async {
    
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: eml.toLowerCase().trim(),
        password: psd.trim(),
      );
      user = userCredential.user;
      user = auth.currentUser;

    } 
    
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return null;
      } else if (e.code == 'email-already-in-use') {
        return null;
      }
    }
    
    catch (e) {
      return null;
    }

  return user;
    
  }

  Future<User?> signInEmailPassword({
    required String eml,
    required String psd,
  }) async {
    
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: eml.toLowerCase().trim(),
        password: psd.trim(),
      );
      user = userCredential.user;
      user = auth.currentUser;

    } 
    
    on FirebaseAuthException catch (e) {
        return null;
      }
    
    catch (e) {
      return null;
    }

  return user;
    
  }

  Future signOut() async {
    await auth.signOut();
    } 
}