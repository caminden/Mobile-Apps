import 'dart:ui';
import 'package:SpiceRack/controller/firebasecontroller.dart';
import 'package:SpiceRack/screens/Alerts/Alert.dart';
import 'package:SpiceRack/screens/Models/recipe.dart';
import 'package:SpiceRack/screens/Models/pantry.dart';
import 'package:SpiceRack/screens/login_screen.dart';
import 'package:SpiceRack/screens/pantry_screen.dart';
import 'package:SpiceRack/screens/recipebook_screen.dart';
import 'package:SpiceRack/screens/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routename = 'homeScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  User user;
  String name;
  _Controller con;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //FireBaseController.initializeFlutterFire();
    con = _Controller(this);
  }

  render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    user ??= ModalRoute.of(context).settings.arguments;
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(user.email),
              accountName:
                  name == null ? Text(user.email.split("@")[0]) : Text(name),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.brown[100],
              ),
            ),
            Container(
              color: Colors.brown[100],
              child: FlatButton(
                child: Text("Sign out"),
                onPressed: con.logout,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.brown[100],
              child: FlatButton(
                child: Text("Settings"),
                onPressed: () => con.settings(user),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.brown[50],
        title: Text("Spice Rack", style: TextStyle(fontSize: 30.0)),
      ),
      //start of body
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wood.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            //start of 1st box
            Stack(
              children: [
                Container(
                  color: Colors.black26,
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 100,
                            color: Colors.brown[50],
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                      color: Colors.black26,
                                      width: 50,
                                      height: 70),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        height: 25,
                                        width: 25,
                                        color: Colors.black12,
                                      ),
                                      Container(
                                        height: 25,
                                        width: 25,
                                        color: Colors.black12,
                                      )
                                    ],
                                  )
                                ]),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            color: Colors.brown[50],
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                      color: Colors.black26,
                                      width: 50,
                                      height: 70),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        height: 25,
                                        width: 25,
                                        color: Colors.black12,
                                      ),
                                      Container(
                                        height: 25,
                                        width: 25,
                                        color: Colors.black12,
                                      )
                                    ],
                                  )
                                ]),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            color: Colors.brown[50],
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                      color: Colors.black26,
                                      width: 50,
                                      height: 70),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        height: 25,
                                        width: 25,
                                        color: Colors.black12,
                                      ),
                                      Container(
                                        height: 25,
                                        width: 25,
                                        color: Colors.black12,
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 100,
                            color: Colors.brown[50],
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                      color: Colors.black26,
                                      width: 50,
                                      height: 70),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        height: 25,
                                        width: 25,
                                        color: Colors.black12,
                                      ),
                                      Container(
                                        height: 25,
                                        width: 25,
                                        color: Colors.black12,
                                      )
                                    ],
                                  )
                                ]),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            color: Colors.brown[50],
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                      color: Colors.black26,
                                      width: 50,
                                      height: 70),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        height: 25,
                                        width: 25,
                                        color: Colors.black12,
                                      ),
                                      Container(
                                        height: 25,
                                        width: 25,
                                        color: Colors.black12,
                                      )
                                    ],
                                  )
                                ]),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            color: Colors.brown[50],
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                      color: Colors.black26,
                                      width: 50,
                                      height: 70),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        height: 25,
                                        width: 25,
                                        color: Colors.black12,
                                      ),
                                      Container(
                                        height: 25,
                                        width: 25,
                                        color: Colors.black12,
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //button
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(0),
                  child: FlatButton(
                    color: Colors.brown[100],
                    child: Text("Visit Recipe Book"),
                    onPressed: () => con.openRecipeBook(user.email),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            //start of 2nd box
            Stack(
              children: [
                Container(
                  color: Colors.black26,
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 200,
                        color: Colors.brown[100],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(height: 10, width: 20, color: Colors.white,),
                                Container(height: 10, width: 20, color: Colors.white,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(height: 10, width: 20, color: Colors.white,),
                                Container(height: 10, width: 20, color: Colors.white,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(height: 10, width: 20, color: Colors.white,),
                                Container(height: 10, width: 20, color: Colors.white,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(height: 10, width: 20, color: Colors.white,),
                                Container(height: 10, width: 20, color: Colors.white,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(height: 10, width: 20, color: Colors.white,),
                                Container(height: 10, width: 20, color: Colors.white,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //button
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(0),
                  child: FlatButton(
                    color: Colors.brown[100],
                    child: Text("Visit Pantry"),
                    onPressed: () => con.openPantry(user.email),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Controller {
  _HomeState _state;
  _Controller(this._state);

  void logout() async {
    try {
      await FireBaseController.logout();
    } catch (e) {}
    Navigator.pushReplacementNamed(_state.context, LoginScreen.routeName);
  }

  void openRecipeBook(String email) async {
    Alert.circularProgressStart(_state.context);
    try {
      List<Recipe> recipes = await FireBaseController.loadRecipes(email);
      Alert.circularProgressEnd(_state.context);
      Navigator.pushNamed(_state.context, RecipeBook.routeName,
          arguments: {"recipes": recipes, "user": _state.user});
    } catch (e) {
      Alert.circularProgressEnd(_state.context);
      Alert.send(_state.context, "Firestore error", "$e");
    }
  }

  void settings(User user) async {
    await Navigator.pushNamed(_state.context, SettingsScreen.routeName,
        arguments: user);
  }

  void openPantry(String email) async {
    Alert.circularProgressStart(_state.context);
    try {
      Pantry pantry = await FireBaseController.loadPantryItems(email);
      Alert.circularProgressEnd(_state.context);
      Navigator.pushNamed(_state.context, PantryScreen.routeName,
          arguments: {"pantry": pantry, "user": _state.user});
    } catch (e) {
      Alert.circularProgressEnd(_state.context);
      Alert.send(_state.context, "Firestore error", "$e");
    }
  }
}
