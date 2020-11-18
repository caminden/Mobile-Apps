import 'package:SpiceRack/screens/Models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Future<List<Recipe>> loadRecipes(String email) async {
    print(email);
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(Recipe.COLLECTION).where(Recipe.OWNER, isEqualTo: email).get();
    print("Reached here");
    var result = <Recipe>[];
    if (snapshot != null && snapshot.docs.length != 0) {
      for (var doc in snapshot.docs) {
        result.add(Recipe.deserialize(doc.data(), doc.id));
      }
    }
    return result;
    //return recipes;
  }
}
