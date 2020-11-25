import 'dart:convert';
import 'dart:io';

import 'package:SpiceRack/controller/firebasecontroller.dart';
import 'package:SpiceRack/screens/Alerts/Alert.dart';
import 'package:SpiceRack/screens/Models/recipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailedRecipe extends StatefulWidget {
  static const routeName = '/recipeBook/detailedRecipe';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DetailedState();
  }
}

class _DetailedState extends State<DetailedRecipe> {
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
    recipe = ModalRoute.of(context).settings.arguments;
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
          onPressed: () {print("Ingredients used");},
        ),
      ),
      body: Container(
        //wood background
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wood.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        //start of info page
        child:
        Container(
          width: 400,
          padding: EdgeInsets.all(5),
          child: Card(
            color: Colors.brown[50],
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Image.network(
                              "${recipe.photoUrl}",
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              height: 100,
                              child: Text("${recipe.name}",
                                  style: TextStyle(fontSize: 25)),
                            ),
                            Container(
                              child: Text("  Prep Time:",
                                  style: TextStyle(fontSize: 20)),
                            ),
                            Container(
                              child: Text("  ${recipe.prepTime}",
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: 400,
                      height: 1,
                      color: Colors.black), //line segment
                  SizedBox(height: 10),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      child: Text(
                        " Ingredients:",
                        style: TextStyle(
                            fontSize: 20, decoration: TextDecoration.underline),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Text("${recipe.ingredients}",
                        style: TextStyle(fontSize: 15)),
                  ),
                  SizedBox(height: 10),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      child: Text(
                        " Instructions:",
                        style: TextStyle(
                            fontSize: 20, decoration: TextDecoration.underline),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text("${recipe.instructions}",
                        style: TextStyle(fontSize: 15,),),
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
  _DetailedState _state;
  _Controller(this._state);
}
