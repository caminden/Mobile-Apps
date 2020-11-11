import 'package:SpiceRack/controller/firebasecontroller.dart';
import 'package:SpiceRack/screens/login_screen.dart';
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
              decoration: BoxDecoration(color: Colors.white),
            ),
            Container(
              child: FlatButton(
                child: Text("Sign out"),
                onPressed: con.logout,
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Home page"),
      ),
      body: Container(
         width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://thepaintpeople.com/wp-content/uploads/2015/09/prepare-bare-wood-staining.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class _Controller{
  _HomeState _state;
  _Controller(this._state);

  void logout() async {
    try{
      await FireBaseController.logout();
    }catch(e){
    }
    Navigator.pushReplacementNamed(_state.context, LoginScreen.routeName);
  }
}