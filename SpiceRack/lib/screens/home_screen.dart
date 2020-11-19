import 'package:SpiceRack/controller/firebasecontroller.dart';
import 'package:SpiceRack/screens/Alerts/Alert.dart';
import 'package:SpiceRack/screens/Models/recipe.dart';
import 'package:SpiceRack/screens/login_screen.dart';
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
                color: Colors.blue,
                ),
            ),
            Container(
              child: FlatButton(
                child: Text("Sign out"),
                onPressed: con.logout,
              ),
            ),
            Container(
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
        backgroundColor: Color.fromARGB(170, 228, 193, 133),
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
            SizedBox(height: 10.0,),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width/3,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: FlatButton(
                color: Colors.brown[100],
                child: Text("Visit Recipe Book"),
                onPressed: () => con.openRecipeBook(user.email),
              ),
            )
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
    try{
      List<Recipe> recipes = await FireBaseController.loadRecipes(email);
      Navigator.pushNamed(_state.context, RecipeBook.routeName, arguments: recipes);
    }catch(e){
      Alert.send(_state.context, "Firestore error", "$e");
    }
  }

  void settings(User user) async {
    await Navigator.pushNamed(_state.context, SettingsScreen.routeName, arguments: user);
    
  }
}
