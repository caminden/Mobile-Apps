import 'package:flutter/material.dart';
import 'package:lesson2/model/profile.dart';

class ProfileDemoScreen extends StatefulWidget {
  static const routeName = '/profileDemoScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfileState();
  }
}

class _ProfileState extends State<ProfileDemoScreen> {
  _Controller con;

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
        appBar: AppBar(
          title: Text("Profile Demo"),
        ),
        body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(20.0),
              color: Colors.blue[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Text(
                "Name: ${con.profile.name}",
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                "Age: ${con.profile.age}",
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                "Classification: ${con.profile.classification.toString().split(".")[1]}",
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                "Major: ${con.profile.major.toString().split(".")[1]}",
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 20.0),
              Text("Languages Proficiency", style: TextStyle(fontSize: 20.0),),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: con.profile.languages[Language.Dart],
                    onChanged: null,
                  ),
                  Text("Dart"),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: con.profile.languages[Language.Java],
                    onChanged: null,
                  ),
                  Text("Java"),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: con.profile.languages[Language.Cpp],
                    onChanged: null,
                  ),
                  Text("Cpp"),
                ],
              ),
          ],
        ),
            )));
  }
}

class _Controller {
  _ProfileState _state;
  _Controller(this._state);
  Profile profile = Profile();
}
