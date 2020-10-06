
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:photomemo/model/photomemo.dart';

class FirebaseController {
  static Future signIn(String email, String password) async {
    AuthResult auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return auth.user;
  }

  static Future<List<PhotoMemo>>getPhotoMemos(String email) async {
    QuerySnapshot querySnapShot = await Firestore.instance
      .collection(PhotoMemo.COLLECTION)
      .where(PhotoMemo.CREATED_BY, isEqualTo: email)
      .getDocuments();
    
    var result = <PhotoMemo>[];
    if(querySnapShot != null && querySnapShot.documents.length != 0){
      for(var doc in querySnapShot.documents){
        result.add(PhotoMemo.deserialize(doc.data, doc.documentID));
      }
    }
    return result;
  }

  static Future<void> signOut()async{
    await FirebaseAuth.instance.signOut();
  }

  static Future<Map<String, String>>uploadStorage({
    @required File image, 
            String filePath,
    @required String uid,
    @required List<dynamic> sharedWith,
    }) async {
      filePath ??= '${PhotoMemo.IMAGE_FOLDER}/$uid/${DateTime.now()}';
      
      StorageUploadTask task = FirebaseStorage.instance.ref().child(filePath).putFile(image);
    var download = await task.onComplete;

    String url = await download.ref.getDownloadURL();

    return {'url': url, 'path': filePath};
  }

static Future<String> addPhotoMemo(PhotoMemo photoMemo) async { 
  photoMemo.updatedAt = DateTime.now();
  DocumentReference ref = await Firestore.instance.collection(PhotoMemo.COLLECTION)
  .add(photoMemo.serialize());
  return ref.documentID;
}

}
