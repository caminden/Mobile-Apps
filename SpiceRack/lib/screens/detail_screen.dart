import 'dart:convert';
import 'dart:io';

import 'package:SpiceRack/controller/firebasecontroller.dart';
import 'package:SpiceRack/screens/Alerts/Alert.dart';
import 'package:SpiceRack/screens/Models/pantry.dart';
import 'package:SpiceRack/screens/Models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    Map map = ModalRoute.of(context).settings.arguments;
    recipe = map['recipe'];
    user = map['user'];
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
          onPressed: con.useIngredients,
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
  List<String> ingredients;
  List<int> indeces = [];

  void useIngredients() async {
    //store ingredients from recipe into array
    ingredients = _state.recipe.ingredients.split(",").map((e) => e.trim()).toList();
    try{
      //get current pantry
      Pantry pantry = await FireBaseController.loadPantryItems(_state.user.email);
      for (int i = 0; i < pantry.items.length; i++) {
        for (int j = 0; j < ingredients.length; j++) {
          //if ingredients from recipe are found in pantry add their incex to array
          if (ingredients[j].toLowerCase() == pantry.items[i].toLowerCase()) {
            indeces.add(i);
          }
        }
      }
      //if number of ingredients in recipe and ingredients found in pantry are the same start removal
      if(indeces.length != ingredients.length){
        print("Ingredients not found");
        Alert.send(_state.context, "Lacking Ingredients", "All ingredients could not be found, check pantry again [and item spelling]");
      }
      else{
        for(int i in indeces){
          pantry.quantity[i]--;
        }
        await FireBaseController.decrementPantryItems(pantry);
        Navigator.pop(_state.context);
        Alert.send(_state.context, "Ingredients Used", "Pantry has been updated accordingly");
      }
    }catch(e){

    }
    
  }
}
