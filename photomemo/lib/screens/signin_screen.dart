import 'package:flutter/material.dart';
import 'package:photomemo/controller/firebasecontroller.dart';
import 'package:photomemo/screens/views/mydialog.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signInScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInState();
  }
}

class _SignInState extends State<SignInScreen> {
  _Controller con;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
            Image.asset('assets/images/postit.png'),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Email",
              ),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              validator: con.validatorEmail,
              onSaved: con.onSavedEmail,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Password",
              ),
              autocorrect: false,
              obscureText: true,
              validator: con.validatorPassword,
              onSaved: con.onSavedPassword,
            ),
            RaisedButton(
              onPressed: con.signIn,
              child: Text("Sign In",
                  style: TextStyle(fontSize: 20.0, color: Colors.white)),
              color: Colors.blue,
            )
          ]),
        )));
  }
}

class _Controller {
  _SignInState _state;
  _Controller(this._state);
  String email;
  String password;

  void signIn() async {
    if (!_state.formKey.currentState.validate()) {
      return;
    }
    _state.formKey.currentState.save();
    print(" === email: $email      password: $password");
    
    try{
      var user = await FirebaseController.signIn(email, password);
      print("USER: $user");
    }catch(e){
      MyDialog.info(
        context: _state.context,
        title: 'Sign In Error',
        content: e.message ?? e.toString(),
      );
    }

  }

  String validatorEmail(String s) {
    if (s == null || !s.contains("@") || !s.contains(".")) {
      return "Invalid email address";
    } else {
      return null;
    }
  }

  void onSavedEmail(String value) {
    email = value;
  }

  String validatorPassword(String s) {
    if (s == null || s.length < 6) {
      return "Password min 6 chars";
    } else {
      return null;
    }
  }

  void onSavedPassword(String value) {
    password = value;
  }
}
