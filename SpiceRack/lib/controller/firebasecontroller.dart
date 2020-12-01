import 'dart:io';

import 'package:SpiceRack/screens/Alerts/Alert.dart';
import 'package:SpiceRack/screens/Models/pantry.dart';
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

  static Future updateEmail(User user, String newEmail) async {
    print("Inside update");
    user.updateEmail(newEmail);
  }

  static Future sendReset(String email) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future delete(Recipe recipe) async {
    await FirebaseFirestore.instance
        .collection(Recipe.COLLECTION)
        .doc(recipe.docID)
        .delete();
    await FirebaseStorage.instance.ref().child(recipe.photoPath).delete();
  }

  static Future<List<Recipe>> searchRecipes(
      {@required String email, @required String name}) async {
    String c = name.substring(0, 1);
    c = c.toUpperCase();
    String b = name.substring(1);
    b = b.toLowerCase();
    name = c + b;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(Recipe.COLLECTION)
        .where(Recipe.OWNER, isEqualTo: email)
        .where(Recipe.NAME, isEqualTo: name)
        .get();

    var result = <Recipe>[];
    if (snapshot != null && snapshot.docs.length != 0) {
      for (var doc in snapshot.docs) {
        result.add(Recipe.deserialize(doc.data(), doc.id));
      }
    }
    return result;
  }


  static Future<Pantry> loadPantryItems(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(Pantry.COLLECTION)
        .where(Pantry.OWNER, isEqualTo: email)
        .get();
    Pantry result;
    if (snapshot != null && snapshot.docs.length != 0) {
      print(snapshot.docs.length);
      for (var doc in snapshot.docs) {
        result = Pantry.deserialize(doc.data(), doc.id);
      }
      return result;
    }
  }


  static Future<String> addPantryItems(Pantry newPantry) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(Pantry.COLLECTION)
        .where(Pantry.OWNER, isEqualTo: newPantry.owner)
        .get();
    Pantry result;
    //if snapshot exists
    if (snapshot != null && snapshot.docs.length != 0) {
      //set result to the current pantry
      for (var doc in snapshot.docs) {
        result = Pantry.deserialize(doc.data(), doc.id);
      }
      Pantry pantry = result;
      bool skip;
      //add into result pantry all items from new pantry
      for (int i = 0; i < newPantry.items.length; i++) {
        skip = false;
        //check old pantry for similar name, if so then add #'s and skip
        for(int j = 0; j < pantry.items.length; j++){
            if(newPantry.items[i] == pantry.items[j]){
              pantry.quantity[j] += newPantry.quantity[i];
              skip = true;
            }
        }
        if(skip != true){
        pantry.items.add(newPantry.items[i]);
        pantry.quantity.add(newPantry.quantity[i]);
        }
      }
      //update doc with new pantry
      await FirebaseFirestore.instance
          .collection(Pantry.COLLECTION)
          .doc(pantry.docID)
          .update(pantry.serialize());
      return pantry.docID;
    } //if snapshot doesnt exist
    else {  //create new snapshot and return ID
      DocumentReference ref = await FirebaseFirestore.instance
          .collection(Pantry.COLLECTION)
          .add(newPantry.serialize());
      return ref.id;
    }
  }
}
