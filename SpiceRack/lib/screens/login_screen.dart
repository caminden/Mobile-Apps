import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  _Controller con;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://thepaintpeople.com/wp-content/uploads/2015/09/prepare-bare-wood-staining.jpg"),
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
                  width: 150.0,
                  child: Text(
                    "Spice",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.black,
                      //fontFamily: ''
                    ),
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  child: Text("Rack",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  height: 200.0,
                ),
                Container(
                  width: 200.0,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Email",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(gapPadding: 20.0)
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: con.validateEmail,
                    onSaved: con.saveEmail,
                  ),
                ),
                SizedBox(height: 15.0,),
                Container(
                  width: 200.0,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "password",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(gapPadding: 20.0)
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    obscureText: true, //change this for variability in future
                    validator: con.validatePassword,
                    onSaved: con.savePassword,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  child: Text("Sign In"),
                  color: Colors.grey,
                  onPressed: con.login,
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
  _LoginScreenState _state;
  _Controller(this._state);
  String email;
  String password;

  //validate function
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

  void login() {
    if (!_state.formKey.currentState.validate()) {
      return;
    }
    _state.formKey.currentState.save();
  }
}
