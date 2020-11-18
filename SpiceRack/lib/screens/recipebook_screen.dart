import 'package:SpiceRack/screens/Models/recipe.dart';
import 'package:flutter/material.dart';

class RecipeBook extends StatefulWidget {
  static const routeName = '/homeScreen/recipeBook';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RecipeBookState();
  }
}

class _RecipeBookState extends State<RecipeBook> {
  _Controller con;
  List<Recipe> recipes;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    recipes ??= ModalRoute.of(context).settings.arguments;
    
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Recipe Book")),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wood.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: recipes == null ? Text("No recipes") : Text("Recipes"),
      ),
    );
  }
}

class _Controller {
  _RecipeBookState _state;
  _Controller(this._state);
}
