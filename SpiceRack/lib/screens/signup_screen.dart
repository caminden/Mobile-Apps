import 'dart:ui';

import 'package:SpiceRack/controller/firebasecontroller.dart';
import 'package:SpiceRack/screens/Alerts/Alert.dart';
import 'package:SpiceRack/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'signUpScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUpScreen> {
  _Controller con;
  var formKey = GlobalKey<FormState>();
  bool visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sign Up",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: con.save,
          )
        ],
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
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                SizedBox(
                  width: 200.0,
                  child: Text(
                    "Enter",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.black,
                      //fontFamily: ''
                    ),
                  ),
                ),
                SizedBox(
                  width: 200.0,
                  child: Text(
                    "Info",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.black,
                      //fontFamily: ''
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  width: 200.0,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "Email",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(gapPadding: 20.0)),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: con.validateEmail,
                    onSaved: con.saveEmail,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 4),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: "Password",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(gapPadding: 20.0)),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        obscureText:
                            visible, //change this for variability in future
                        validator: con.validatePassword,
                        onSaved: con.savePassword,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        if (visible == true) {
                          visible = false;
                        } else {
                          visible = true;
                        }
                        ;
                        render(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _SignUpState _state;
  _Controller(this._state);
  String email, password;

  String validateEmail(String s) {
    if (s == null || !s.contains("@") || !s.contains(".")) {
      return "Invalid email address";
    } else {
      return null;
    }
  }

  //save function
  void saveEmail(String s) {
    email = s;
  }

  //validate function
  String validatePassword(String s) {
    if (s == null || s.length < 6) {
      return "Password must be > 6 characters";
    } else {
      return null;
    }
  }

  //save function
  void savePassword(String s) {
    password = s;
  }

  void save() async {
    if (!_state.formKey.currentState.validate()) {
      return;
    }
    _state.formKey.currentState.save();

    try {
      UserCredential newuser = await FireBaseController.signUp(email, password);
      //print("********");
    } catch (e) {
      Alert.send(_state.context, "Sign Up Error", e.message);
      return;
    }
    Navigator.pushReplacementNamed(_state.context, LoginScreen.routeName);
  }
}
