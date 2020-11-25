import 'dart:io';

import 'package:SpiceRack/controller/firebasecontroller.dart';
import 'package:SpiceRack/screens/Alerts/Alert.dart';
import 'package:SpiceRack/screens/Models/recipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipe extends StatefulWidget {
  static const routeName = '/recipeBook/addRecipe';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddRecipeState();
  }
}

class _AddRecipeState extends State<AddRecipe> {
  _Controller con;
  var formKey = GlobalKey<FormState>();
  File image;
  User user;
  List<Recipe> recipes;

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
    recipes ??= map['recipes'];
    //print(user);
    // TODO: implement build
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.brown[100],
        ),
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: con.save,
        ),
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
                            ? Icon(
                                Icons.filter_frames,
                                size: 300,
                                color: Colors.brown[100],
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
                        autocorrect: true,
                        maxLines: 4,
                        validator: con.validateIngredients,
                        onSaved: con.saveIngredients),
                  ),
                  Container(
                    width: 350,
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Instructions",
                      ),
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
  _AddRecipeState _state;
  _Controller(this._state);
  String name;
  String instructions;
  String ingredients;
  String preptime;

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
    if (_state.image == null) {
      Alert.send(
          _state.context, "No Picture", "The recipe must include a picture");
      return;
    }
    _state.formKey.currentState.save();

    try {
      Map<String, String> photo = await FireBaseController.addPic(
        image: _state.image,
        uid: _state.user.uid,
      );

      var r = Recipe(
        owner: _state.user.email,
        name: name,
        prepTime: preptime,
        ingredients: ingredients,
        instructions: instructions,
        photoPath: photo['path'],
        photoUrl: photo['url'],
      );

      r.docID = await FireBaseController.addRecipe(r);
      _state.recipes.insert(0, r);
      Navigator.pop(_state.context);
      Alert.send(_state.context, "Add Recipe Complete", "recipe successfully added");
    } catch (e) {
      Alert.send(_state.context, "Add Recipe error", e.message);
    }
  }

  //start validators
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
    name = c+b; 
  }

  void savePrep(String s) {
    preptime = s;
  }

  void saveIngredients(String s) {
    ingredients = s;
  }

  void saveInstructions(String s) {
    instructions = s;
  }
}
