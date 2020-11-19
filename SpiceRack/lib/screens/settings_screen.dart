import 'package:SpiceRack/controller/firebasecontroller.dart';
import 'package:SpiceRack/screens/Alerts/Alert.dart';
import 'package:SpiceRack/screens/home_screen.dart';
import 'package:SpiceRack/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settingsScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  _Controller con;
  var formKey = GlobalKey<FormState>();
  bool visible = true, visible2 = true;
  User user;
  String email;
  bool changePW = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context).settings.arguments;
    email = user.email;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings"),
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
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    initialValue: email,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "Email",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(gapPadding: 20.0)),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    onChanged: con.updateEmail,
                    validator: con.validateEmail,
                    onSaved: con.saveEmail,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text("Change password?"),
                Switch(
                    value: changePW,
                    onChanged: (value) {
                      render(() {
                        changePW = value;
                      });
                    }),
                changePW == false
                    ? SizedBox()
                    : Column(
                        children: <Widget>[
                          Row(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 4),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      hintText: "Old Password",
                                      filled: true,
                                      fillColor: Colors.white,
                                      border:
                                          OutlineInputBorder(gapPadding: 20.0)),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  obscureText:
                                      visible2, //change this for variability in future
                                  validator: con.validatePassword,
                                  onSaved: con.savePassword,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.visibility),
                                onPressed: () {
                                  if (visible2 == true) {
                                    visible2 = false;
                                  } else {
                                    visible2 = true;
                                  }
                                  render(() {});
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 4),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      hintText: "New Password",
                                      filled: true,
                                      fillColor: Colors.white,
                                      border:
                                          OutlineInputBorder(gapPadding: 20.0)),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  obscureText:
                                      visible, //change this for variability in future
                                  validator: con.validateNewPassword,
                                  onSaved: con.saveNewPassword,
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
                                  render(() {});
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                RaisedButton(
                  child: Text("Update and sign out"),
                  color: Colors.grey,
                  onPressed: con.changeCreds,
                ),
                SizedBox(
                  height: 50.0,
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
  _SettingsScreenState _state;
  _Controller(this._state);
  String newEmail;
  String password;
  String newPassword;

  String updateEmail(String s) {
    if (s == null || !s.contains("@") || !s.contains(".")) {
      return "Invalid email address";
    } else {
      newEmail = s;
      return null;
    }
  }

  void saveEmail(String s) {
    newEmail = s;
  }

  String validateEmail(String s) {
    if (s == null || !s.contains("@") || !s.contains(".")) {
      return "Invalid email address";
    } else {
      return null;
    }
  }

  void savePassword(String s) {
    password = s;
  }

  String validatePassword(String s) {
    if (s == null || s.length < 6) {
      return "Password must be > 6 characters";
    } else {
      return null;
    }
  }

  void saveNewPassword(String s) {
    newPassword = s;
  }

  String validateNewPassword(String s) {
    if (s == null || s.length < 6) {
      return "Password must be > 6 characters";
    } else {
      return null;
    }
  }

  void changeCreds() async {
    if (!_state.formKey.currentState.validate()) {
      return;
    }
    _state.formKey.currentState.save();

    String oldEmail = _state.user.email;

    if (_state.changePW == true) {
      if (newPassword == password) {
        Alert.send(_state.context, "Password error", 'Passwords cannot match');
        return;
      }
      //update password
      try {
        await FireBaseController.updateEmail(_state.user, newEmail);
        UserCredential cred = await FireBaseController.updatePW(
            newEmail, password, newPassword);
        if (cred != null) {
          _state.user = cred.user;
        }
      } catch (e) {
        FireBaseController.updateEmail(_state.user, oldEmail);
        FireBaseController.updatePW(oldEmail, password, password);
        Alert.send(_state.context, "Could not change settings\n", e.message);
        return;
      }
    }else{
      try{
      FireBaseController.updateEmail(_state.user, newEmail);
      }catch(e){
        FireBaseController.updateEmail(_state.user, oldEmail);
        FireBaseController.updatePW(oldEmail, password, password);
      }
    }
    //update email
    Navigator.pushNamed(_state.context, LoginScreen.routeName);
  }
}
