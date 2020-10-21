import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photomemo/controller/firebasecontroller.dart';
import 'package:photomemo/model/photomemo.dart';
import 'package:photomemo/screens/views/mydialog.dart';
import 'package:photomemo/screens/views/myimageview.dart';

class EditScreen extends StatefulWidget {
  static const routeName = '/detailedScreen/editScreen';

  @override
  State<StatefulWidget> createState() {
    return _EditState();
  }
}

class _EditState extends State<EditScreen> {
  _Controller con;
  PhotoMemo photoMemo;
  FirebaseUser user;
  var formKey = GlobalKey<FormState>();
  bool isPublic;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    user ??= args['user'];
    photoMemo ??= args['photoMemo'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit PhotoMemo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: con.save,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: con.imageFile == null
                        ? MyImageView.network(
                            imageUrl: photoMemo.photoURL, context: context)
                        : Image.file(con.imageFile, fit: BoxFit.fill),
                  ),
                  Positioned(
                    right: 0.0,
                    bottom: 0.0,
                    child: Container(
                      color: Colors.blue[100],
                      child: PopupMenuButton<String>(
                        onSelected: con.getPicture,
                        itemBuilder: (context) => <PopupMenuEntry<String>>[
                          PopupMenuItem(
                            value: 'camera',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.photo_camera),
                                Text("Camera"),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'gallery',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.photo_library),
                                Text("Gallery"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              con.uploadProgress == null
                  ? SizedBox(height: 1.0)
                  : Text(
                      con.uploadProgress,
                      style: TextStyle(fontSize: 20.0),
                    ),
              TextFormField(
                style: TextStyle(fontSize: 20.0),
                decoration: InputDecoration(
                  hintText: "title",
                ),
                initialValue: photoMemo.title,
                autocorrect: true,
                validator: con.validatorTitle,
                onSaved: con.onSavedTitle,
              ),
              TextFormField(
                style: TextStyle(fontSize: 15.0),
                decoration: InputDecoration(
                  hintText: "enter memo",
                ),
                initialValue: photoMemo.memo,
                autocorrect: true,
                keyboardType: TextInputType.multiline,
                maxLines: 7,
                validator: con.validatorMemo,
                onSaved: con.onSavedMemo,
              ),
              TextFormField(
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                  hintText: "shared with",
                ),
                initialValue: photoMemo.sharedWith.join(","),
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                validator: con.validatorSharedWith,
                onSaved: con.onSavedSharedWith,
              ),
              SizedBox(height: 10,),
              Text("Switch publicity?"),
              Switch(
                value: photoMemo.public,
                onChanged: (value) {
                  render((){photoMemo.public = value;});
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _EditState _state;
  _Controller(this._state);
  File imageFile;
  String uploadProgress;

  void save() async {
    if (!_state.formKey.currentState.validate()) return;
    _state.formKey.currentState.save();

    try {
      MyDialog.circularProgressStart(_state.context);

      if (imageFile != null) {
        //this means image change
        Map<String, String> photo = await FirebaseController.uploadStorage(
          image: imageFile,
          uid: _state.user.uid,
          sharedWith: _state.photoMemo.sharedWith,
          listener: (progress){
            _state.render((){
              uploadProgress = 'Uploading ${(progress).toStringAsFixed(1)} %';
            });
          },
        );
        _state.photoMemo.photoPath = photo['path'];
        _state.photoMemo.photoURL = photo['url'];
        _state.photoMemo.public = _state.isPublic;

        _state.render(() => uploadProgress = 'ML Image Labeler started');
        List<String> labels =
            await FirebaseController.getImageLabels(imageFile);
        _state.photoMemo.imageLabels = labels;
      } else {
        //no image change
      }

      _state.render(() => uploadProgress = 'Firestore doc updating...');
      await FirebaseController.updatePhotoMemo(_state.photoMemo);
      MyDialog.circularProgressEnd(_state.context);
      Navigator.pop(_state.context);
    } catch (e) {
      MyDialog.circularProgressEnd(_state.context);
      MyDialog.info(
        context: _state.context,
        title: "Edit Photomemo error in saving",
        content: e.message ?? e.toString(),
      );
    }
    //update storage if new pic is chosen
    //update firestore with new doc
  }

  String validatorTitle(String value) {
    if (value.length < 2) {
      return 'Min 2 chars';
    } else {
      return null;
    }
  }

  void onSavedTitle(String value) {
    _state.photoMemo.title = value;
  }

  String validatorMemo(String value) {
    if (value.length < 2) {
      return 'Min 3 chars';
    } else {
      return null;
    }
  }

  void onSavedMemo(String value) {
    _state.photoMemo.memo = value;
  }

  String validatorSharedWith(String value) {
    if (value.trim().length == 0) return null;

    List<String> emailList = value.split(",").map((e) => e.trim()).toList();
    for (String email in emailList) {
      if (!(email.contains("@") && email.contains("."))) {
        return 'Comma(,) seperated email list';
      }
    }
    return null;
  }

  void onSavedSharedWith(String value) {
    if (value.trim().length != 0) {
      _state.photoMemo.sharedWith =
          value.split(",").map((e) => e.trim()).toList();
    }
  }

  void getPicture(String src) async {
    try {
      PickedFile _imageFile;
      if (src == 'camera') {
        _imageFile = await ImagePicker().getImage(source: ImageSource.camera);
      } else {
        _imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
      }
      _state.render(() {
        imageFile = File(_imageFile.path);
      });
    } catch (e) {
      MyDialog.info(
        context: _state.context,
        title: "getPicture from camera/gallery",
        content: e.message ?? e.toString(),
      );
    }
  }
}
