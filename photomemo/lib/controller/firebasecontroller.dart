import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:photomemo/model/photomemo.dart';

class FirebaseController {
  //function
  static Future signIn(String email, String password) async {
    AuthResult auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return auth.user;
  }

  //function
  static Future<List<PhotoMemo>> getPhotoMemos(String email) async {
    QuerySnapshot querySnapShot = await Firestore.instance
        .collection(PhotoMemo.COLLECTION)
        .where(PhotoMemo.CREATED_BY, isEqualTo: email)
        .orderBy(PhotoMemo.UPDATED_AT, descending: true)
        .getDocuments();

    var result = <PhotoMemo>[];
    if (querySnapShot != null && querySnapShot.documents.length != 0) {
      for (var doc in querySnapShot.documents) {
        result.add(PhotoMemo.deserialize(doc.data, doc.documentID));
      }
    }
    return result;
  }

  //function
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //function
  static Future<Map<String, String>> uploadStorage({
    @required File image,
    String filePath,
    @required String uid,
    @required List<dynamic> sharedWith,
    @required Function listener,
  }) async {
    filePath ??= '${PhotoMemo.IMAGE_FOLDER}/$uid/${DateTime.now()}';
    StorageUploadTask task =
        FirebaseStorage.instance.ref().child(filePath).putFile(image);
    task.events.listen((event) {
      double percentage = event.snapshot.bytesTransferred.toDouble() /
          event.snapshot.totalByteCount.toDouble() *
          100;
      listener(percentage);
    });
    var download = await task.onComplete;
    String url = await download.ref.getDownloadURL();
    return {'url': url, 'path': filePath};
  }

  //function
  static Future<String> addPhotoMemo(PhotoMemo photoMemo) async {
    photoMemo.updatedAt = DateTime.now();
    DocumentReference ref = await Firestore.instance
        .collection(PhotoMemo.COLLECTION)
        .add(photoMemo.serialize());
    return ref.documentID;
  }

  //function
  static Future<List<dynamic>> getImageLabels(File imageFile) async {
    //ML kit
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    ImageLabeler cloudLabeler = FirebaseVision.instance.cloudImageLabeler();
    List<ImageLabel> cloudLabels = await cloudLabeler.processImage(visionImage);

    var labels = <String>[];
    for (ImageLabel label in cloudLabels) {
      String text = label.text.toLowerCase();
      double confidence = label.confidence;
      if (confidence >= PhotoMemo.MIN_CONFIDENCE) labels.add(text);
    }
    cloudLabeler.close();
    return labels;
  }

  //function
  static Future<void> deletePhotoMemo(PhotoMemo photoMemo) async {
    await Firestore.instance
        .collection(PhotoMemo.COLLECTION)
        .document(photoMemo.docId)
        .delete();
    await FirebaseStorage.instance.ref().child(photoMemo.photoPath).delete();
  }

  //function
  static Future<List<PhotoMemo>> searchImages({
    @required String email,
    @required String imageLabel,
  }) async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(PhotoMemo.COLLECTION)
        .where(PhotoMemo.CREATED_BY, isEqualTo: email)
        .where(PhotoMemo.IMAGE_LABELS, arrayContains: imageLabel.toLowerCase())
        .orderBy(PhotoMemo.UPDATED_AT, descending: true)
        .getDocuments();

    var result = <PhotoMemo>[];
    if(querySnapshot != null && querySnapshot.documents.length != 0){
      for(var doc in querySnapshot.documents){
        result.add(PhotoMemo.deserialize(doc.data, doc.documentID));
      }
    }
    return result;
  }

  //function
  static Future<void> updatePhotoMemo(PhotoMemo photoMemo)async{
    photoMemo.updatedAt = DateTime.now();
    await Firestore.instance.collection(PhotoMemo.COLLECTION)
    .document(photoMemo.docId)
    .setData(photoMemo.serialize());
  }

}
