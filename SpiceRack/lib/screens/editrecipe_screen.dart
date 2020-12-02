import 'dart:io';

import 'package:SpiceRack/controller/firebasecontroller.dart';
import 'package:SpiceRack/screens/Alerts/Alert.dart';
import 'package:SpiceRack/screens/Models/recipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditRecipe extends StatefulWidget {
  static const routeName = '/recipeBook/editRecipe';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditRecipeState();
  }
}

class _EditRecipeState extends State<EditRecipe> {
  _Controller con;
  var formKey = GlobalKey<FormState>();
  File image;
  User user;
  Recipe recipe;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    user ??= map['user'];
    recipe ??= map['recipe'];
    //print(user);
    // TODO: implement build
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.brown[100],
        ),
        child: IconButton(
          icon: Icon(Icons.check),
          onPressed: con.save,
        ),
      ),
      appBar: AppBar(
        title: Text("Edit Recipe"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/page.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: image == null
                            ? Image.network(
                                recipe.photoUrl,
                                alignment: Alignment.center,
                                scale: 3,
                              )
                            : Image.file(
                                image,
                                alignment: Alignment.center,
                                scale: 3,
                              ),
                      ),
                      Positioned(
                        right: 0.0,
                        bottom: 0.0,
                        child: Container(
                          color: Colors.transparent,
                          child: PopupMenuButton<String>(
                            onSelected: con.getPicture,
                            itemBuilder: (context) => <PopupMenuEntry<String>>[
                              PopupMenuItem(
                                value: 'Gallery',
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.photo_album),
                                    Text("Gallery"),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'Camera',
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.photo_camera),
                                    Text("Camera"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 75.0,
                  ),
                  Container(
                    width: 350.0,
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Name",
                      ),
                      initialValue: recipe.name,
                      autocorrect: true,
                      textAlign: TextAlign.center,
                      validator: con.validateName,
                      onSaved: con.saveName,
                    ),
                  ),
                  Container(
                    width: 350,
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Prep time",
                      ),
                      initialValue: recipe.prepTime,
                      autocorrect: true,
                      keyboardType: TextInputType.number,
                      validator: con.validatePrep,
                      onSaved: con.savePrep,
                    ),
                  ),
                  Container(
                    width: 350,
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Ingredients {seperated with , }",
                      ),
                      initialValue: recipe.ingredients,
                      autocorrect: true,
                      maxLines: 4,
                      validator: con.validateIngredients,
                      onSaved: con.saveIngredients,
                    ),
                  ),
                  Container(
                    width: 350,
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Instructions",
                      ),
                      initialValue: recipe.instructions,
                      autocorrect: true,
                      maxLines: 10,
                      validator: con.validateInstructions,
                      onSaved: con.saveInstructions,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _EditRecipeState _state;
  _Controller(this._state);

  void getPicture(String src) async {
    try {
      PickedFile _imageFile;
      if (src == "Camera") {
        _imageFile = await ImagePicker().getImage(source: ImageSource.camera);
      } else {
        _imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
      }
      _state.render(() {
        _state.image = File(_imageFile.path);
      });
    } catch (e) {}
  }

  void save() async {
    if (!_state.formKey.currentState.validate()) {
      return;
    }
    _state.formKey.currentState.save();

    try {
      if (_state.image != null) {
        Map<String, String> photo = await FireBaseController.addPic(
          image: _state.image,
          uid: _state.user.uid,
        );
        _state.recipe.photoPath = photo['path'];
        _state.recipe.photoUrl = photo['url'];
      } else {
        //nothing
      }

      await FireBaseController.updateRecipe(_state.recipe);
      Navigator.pop(_state.context);
      Alert.send(
          _state.context, "Recipe Updated", "update successful");
    } catch (e) {
      Alert.send(_state.context, "Add Recipe error", e.message);
    }
  }

  String validateName(String s) {
    if (s.isEmpty) {
      print("Here");
      return "Name cannot be empty";
    }
    return null;
  }

  String validatePrep(String s) {
    if (s.isEmpty) {
      return "Please input a prep time";
    }
    return null;
  }

  String validateIngredients(String s) {
    if (s.isEmpty) {
      return "Please input ingredients";
    }
    return null;
  }

  String validateInstructions(String s) {
    if (s.isEmpty) {
      return "Please input instructions";
    }
    return null;
  }

  //start saves
  void saveName(String s) {
    String c = s.substring(0, 1);
    c = c.toUpperCase();
    String b = s.substring(1);
    b = b.toLowerCase();
    _state.recipe.name = c + b;
  }

  void savePrep(String s) {
    _state.recipe.prepTime = s;
  }

  void saveIngredients(String s) {
    _state.recipe.ingredients = s;
  }

  void saveInstructions(String s) {
    _state.recipe.instructions = s;
  }
}
