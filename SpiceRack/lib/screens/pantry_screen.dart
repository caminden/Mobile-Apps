import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Pantry extends StatefulWidget {
  static const routeName = '/homePage/pantry';

  @override
  State<StatefulWidget> createState() {
    return _PantryState();
  }
}

class _PantryState extends State<Pantry> {
  _Controller con;
  User user;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    
    user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantry"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wood.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Text("${user.email}", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class _Controller {
  _PantryState _state;
  _Controller(this._state);
}
