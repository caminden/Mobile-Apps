import 'package:SpiceRack/screens/Models/recipe.dart';
import 'package:SpiceRack/screens/addrecipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    recipes ??= ModalRoute.of(context).settings.arguments;
    print(recipes.length);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Recipe Book")),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/wood.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: recipes == null
              ? Text("No recipes")
              : ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (BuildContext context, int index) => SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Card(
                      color: Colors.white,
                      child: Text("Recipe: ${recipes[index].name}"),
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButton: RaisedButton(
        onPressed: con.addRecipe,
        child: Icon(Icons.add),
      ),
    );
  }
}

@override
State<StatefulWidget> createState() {
  // TODO: implement createState
  throw UnimplementedError();
}

class _Controller {
  _RecipeBookState _state;
  _Controller(this._state);

  void addRecipe() {
    Navigator.pushNamed(_state.context, AddRecipe.routeName);
  }
}
