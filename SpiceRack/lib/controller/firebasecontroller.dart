import 'dart:io';

import 'package:SpiceRack/screens/Alerts/Alert.dart';
import 'package:SpiceRack/screens/Models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  //load recipes from button on homescreen
  static Future<List<Recipe>> loadRecipes(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(Recipe.COLLECTION)
        .where(Recipe.OWNER, isEqualTo: email)
        .get();
    var result = <Recipe>[];
    if (snapshot != null && snapshot.docs.length != 0) {
      for (var doc in snapshot.docs) {
        result.add(Recipe.deserialize(doc.data(), doc.id));
      }
    }
    return result;
  }

  static Future<Map<String, String>> addPic({
    @required File image,
    @required String uid,
  }) async {
    String filePath = "${Recipe.IMAGE_FOLDER}/$uid/${DateTime.now()}";
    await FirebaseStorage.instance.ref().child(filePath).putFile(image);
    var url = await FirebaseStorage.instance.ref(filePath).getDownloadURL();
    return {"url": url, "path": filePath};
  }

  //add recipes
  static Future<String> addRecipe(Recipe rec) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection(Recipe.COLLECTION)
        .add(rec.serialize());
    return ref.id;
  }

  static Future updatePW(
      String email, String password, String newPassword) async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    user.user.updatePassword(newPassword);
  }

  static Future updateEmail(
      User user, String newEmail) async {
    print("Inside update");
    user.updateEmail(newEmail);
  }

  static Future sendReset(String email) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
