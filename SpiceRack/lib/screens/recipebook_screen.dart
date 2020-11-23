import 'package:SpiceRack/screens/Models/recipe.dart';
import 'package:SpiceRack/screens/addrecipe_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  User user;
  int halfLength;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    recipes ??= map["recipes"];
    user ??= map['user'];

    halfLength = recipes.length ~/ 2;
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
                  scrollDirection: Axis.horizontal,
                  itemCount: recipes.length - halfLength,
                  itemBuilder: (BuildContext context, int index) {
                    index = index * 2;
                    return SizedBox(
                      width: 400.0,
                      child: Column(
                        children: [
                          Container(
                            width: 400,
                            height: 300,
                            child: Card(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(10),
                                          width: 150,
                                          height: 150,
                                          child: Image.network(
                                            "${recipes[index].photoUrl}",
                                          )),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text("${recipes[index].name}",
                                          style: TextStyle(fontSize: 25)),
                                    ],
                                  ),
                                  Text("  Ingredients:",
                                      style: TextStyle(fontSize: 20)),
                                  Text("  ${recipes[index].ingredients}",
                                      style: TextStyle(fontSize: 20)),
                                  Container(
                                    width: 400,
                                    height: 80,
                                    alignment: Alignment.bottomCenter,
                                    child: Text("Click for more"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          index + 1 < recipes.length
                              ? Container(
                                  width: 400,
                                  height: 300,
                                  child: Card(
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                padding: EdgeInsets.all(10),
                                                width: 150,
                                                height: 150,
                                                child: Image.network(
                                                  "${recipes[index+1].photoUrl}",
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Text(
                                                "${recipes[index+1].name}",
                                                style: TextStyle(fontSize: 25)),
                                          ],
                                        ),
                                        Text("  Ingredients:",
                                            style: TextStyle(fontSize: 20)),
                                        Text("  ${recipes[index+1].ingredients}",
                                            style: TextStyle(fontSize: 20)),
                                        Container(
                                          width: 400,
                                          height: 80,
                                          alignment: Alignment.bottomCenter,
                                          child: Text("Click for more"),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: 400,
                                ),
                        ],
                      ),
                    );
                  }),
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
    Navigator.pushNamed(_state.context, AddRecipe.routeName, arguments: {
      'user': _state.user,
      'recipes': _state.recipes,
    });
  }
}
