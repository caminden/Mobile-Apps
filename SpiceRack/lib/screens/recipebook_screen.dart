import 'package:SpiceRack/controller/firebasecontroller.dart';
import 'package:SpiceRack/screens/Alerts/Alert.dart';
import 'package:SpiceRack/screens/Models/recipe.dart';
import 'package:SpiceRack/screens/addrecipe_screen.dart';
import 'package:SpiceRack/screens/detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

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
  User user;
  int halfLength;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    recipes ??= map["recipes"];
    user ??= map['user'];

    halfLength = recipes.length ~/ 2;
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Recipe Book"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            width: 150.0,
            child: Form(
              key: formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search Recipe",
                  fillColor: Colors.white,
                  filled: true,
                ),
                autocorrect: false,
                onSaved: con.onSavedSearchKey,
              ),
            ),
          ),
          con.delIndex == null
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: con.search,
                )
              : IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: con.delete,
                ),
        ],
      ),
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
                          GestureDetector(
                            onLongPress: () => con.longPress(index),
                            onTap: () => con.onTap(index),
                            child: Container(
                              width: 400,
                              height: 300,
                              child: Card(
                                color: con.delIndex != null &&
                                        con.delIndex == index
                                    ? Colors.yellow[100]
                                    : Colors.brown[50],
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                        width: MediaQuery.of(context).size.width / 2,
                                        padding: EdgeInsets.all(10),
                                        child: Image.network(
                                          "${recipes[index].photoUrl}",
                                        )),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            child: Expanded(
                                              child: Text(
                                                  "${recipes[index].name}",
                                                  style:
                                                      TextStyle(fontSize: 25)),
                                            ),
                                          ),
                                          Container(
                                              child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Text("  Prep Time:",
                                                    style: TextStyle(
                                                        fontSize: 20)),
                                              ),
                                              Container(
                                                child: Text(
                                                    "  ${recipes[index].prepTime}",
                                                    style: TextStyle(
                                                        fontSize: 20)),
                                              ),
                                            ],
                                          )),
                                          Container(
                                            height: 80,
                                            alignment: Alignment.bottomCenter,
                                            child: Text("Click for more"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          index + 1 < recipes.length
                              ? GestureDetector(
                                  onLongPress: () => con.longPress(index + 1),
                                  onTap: () => con.onTap(index + 1),
                                  child: Container(
                                    width: 400,
                                    height: 300,
                                    child: Card(
                                      color: con.delIndex != null &&
                                              con.delIndex == index + 1
                                          ? Colors.yellow[100]
                                          : Colors.brown[50],
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width / 2,
                                              padding: EdgeInsets.all(10),
                                              child: Image.network(
                                                "${recipes[index + 1].photoUrl}",
                                              )),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Expanded(
                                                    child: Text(
                                                        "${recipes[index + 1].name}",
                                                        style: TextStyle(
                                                            fontSize: 25)),
                                                  ),
                                                ),
                                                Container(
                                                    child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                          "  Prep Time:",
                                                          style: TextStyle(
                                                              fontSize: 20)),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                          "  ${recipes[index + 1].prepTime}",
                                                          style: TextStyle(
                                                              fontSize: 20)),
                                                    ),
                                                  ],
                                                )),
                                                Container(
                                                  height: 80,
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Text("Click for more"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
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
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.brown[100],
        ),
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: con.addRecipe,
        ),
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
  int delIndex;
  String searchKey;

  void addRecipe() async {
    await Navigator.pushNamed(_state.context, AddRecipe.routeName, arguments: {
      'user': _state.user,
      'recipes': _state.recipes,
    });
    _state.render(() {});
  }

  void longPress(int index) {
    _state.render(() {
      delIndex = (delIndex == index ? null : index);
    });
  }

  void onTap(int index) async {
    if (delIndex != null) {
      _state.render(() => delIndex = null);
      return;
    }
    await Navigator.pushNamed(_state.context, DetailedRecipe.routeName,
        arguments: {'recipe': _state.recipes[index], 'user': _state.user});
  }

  void delete() async {
    try {
      Recipe recipe = _state.recipes[delIndex];
      await FireBaseController.delete(recipe);
      _state.render(() {
        _state.recipes.removeAt(delIndex);
        delIndex = null;
      });
    } catch (e) {
      Alert.send(_state.context, "Deletion error", e.message);
    }
  }

  void onSavedSearchKey(String s) {
    searchKey = s;
  }

  void search() async {
    _state.formKey.currentState.save();

    var result;
    if (searchKey == null || searchKey.trim().isEmpty) {
      result = await FireBaseController.loadRecipes(_state.user.email);
    } else {
      result = await FireBaseController.searchRecipes(
          email: _state.user.email, name: searchKey);
    }

    _state.render(() => _state.recipes = result);
  }
}
