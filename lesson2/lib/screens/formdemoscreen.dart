import 'package:flutter/material.dart';
import 'package:lesson2/screens/userhome_screen.dart';

class FormDemoScreen extends StatefulWidget {
  static const routeName = '/formDemoScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FormDemoScreen();
  }
}

class _FormDemoScreen extends State<FormDemoScreen> {
  _Controller con;
  String errorMessage;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Demo Screen"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Text(
              "Sign in please",
              style: TextStyle(fontSize: 20.0),
            ),
            errorMessage == null
                ? SizedBox(
                    height: 1.0,
                  )
                : Text(
                    errorMessage,
                    style: TextStyle(fontSize: 15.0, color: Colors.red),
                  ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              validator: con.validatorEmail,
              onSaved: con.onSavedEmail,
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Password',
              ),
              autocorrect: false,
              obscureText: true, //hide characters
              validator: con.validatorPassword,
              onSaved: con.onSavedPassword,
            ),
            RaisedButton(
              child: Text("Sign in"),
              onPressed: con.signIn,
            )
          ]),
        ),
      ),
    );
  }
}

class _Controller {
  _FormDemoScreen _state;
  _Controller(this._state);
  Map userInfo = {};

  void signIn() {
    if (_state.formKey.currentState.validate()) {
      _state.formKey.currentState.save();
      if (userInfo['password'] != 'pppp') {
        _state.render((){
          _state.errorMessage = "Incorrect email/password";
        });
        return;
      }
      //print('***********' + userInfo.toString());

      //successful sign in
      Navigator.pushNamed(_state.context, UserHomeScreen.routeName, arguments: userInfo);
    }
  }

  String validatorEmail(String value) {
    if (value.contains('@') && value.contains('.')) {
      return null;
    } else {
      return 'not valid email format';
    }
  }

  void onSavedEmail(String value) {
    userInfo['email'] = value;
  }

  String validatorPassword(String value) {
    if (value.length < 4) {
      return "min 4 chars";
    } else {
      return null;
    }
  }

  void onSavedPassword(String value) {
    userInfo['password'] = value;
  }
}
