import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FireBaseController {
  static void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {}
  }

  static Future login(String email, String password) async {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future signUp(String email, String password) async {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
