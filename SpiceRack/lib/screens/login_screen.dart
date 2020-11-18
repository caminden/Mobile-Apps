import 'package:SpiceRack/controller/firebasecontroller.dart';
import 'package:SpiceRack/screens/Alerts/Alert.dart';
import 'package:SpiceRack/screens/home_screen.dart';
import 'package:SpiceRack/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_core/firebase_core.dart';

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
  bool visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FireBaseController.initializeFlutterFire();
    con = _Controller(this);
  }

  render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                  width:  MediaQuery.of(context).size.width/2,
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
                    SizedBox(width: MediaQuery.of(context).size.width/4),
                    Container(
                      width: MediaQuery.of(context).size.width/2,
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
                        };
                        render((){});
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  child: Text("Sign In"),
                  color: Colors.grey,
                  onPressed: con.login,
                ),
                SizedBox(height: 50.0,),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      height: 100.0,
                      alignment: Alignment.bottomLeft,
                      child: FlatButton(
                        color: Colors.transparent,
                        child: Text("Sign Up Here",
                            style: TextStyle(fontSize: 15.0)),
                        onPressed: con.signUp,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      height: 100.0,
                      alignment: Alignment.bottomRight,
                      child: FlatButton(
                        color: Colors.transparent,
                        child: Text("Forgot password",
                            style: TextStyle(fontSize: 15.0)),
                        onPressed: () {},
                      ),
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

  //function for initial login
  void login() async {
    if (!_state.formKey.currentState.validate()) {
      return;
    }
    _state.formKey.currentState.save();

    try {
      UserCredential cred = await FireBaseController.login(email, password);
      //print("CRED: $cred\n");
      User u = cred.user;
      if (cred != null) {
        Navigator.pushReplacementNamed(_state.context, HomeScreen.routename,
            arguments: u);
      }
    } catch (e) {
      Alert.send(_state.context, "Login Error", e.message);
      //statement for when login fails, fix to return as error message
    }
  }

  void signUp() {
    Navigator.pushNamed(_state.context, SignUpScreen.routeName);
  }

  void forgotPassword() {}
}
