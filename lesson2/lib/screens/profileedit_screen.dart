import 'package:flutter/material.dart';
import 'package:lesson2/model/profile.dart';

class ProfileEditScreen extends StatefulWidget {
  static const routeName = '/profileScreen/profileEditScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfileEditState();
  }
}

class _ProfileEditState extends State<ProfileEditScreen> {
  _Controller con;
  var formKey = GlobalKey<FormState>();
  Profile profile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    profile = ModalRoute.of(context).settings.arguments;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.face),
                labelText: "Name:",
              ),
              autocorrect: false,
              initialValue: profile.name,
              validator: con.validatorName,
              onSaved: con.onSavedName,
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.today),
                labelText: "Age:",
              ),
              autocorrect: false,
              keyboardType: TextInputType.number,
              initialValue: profile.age.toString(),
              validator: con.validatorAge,
              onSaved: con.onSavedAge,
            ),
            SizedBox(height: 20.0),
            Text("Major"),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.blue),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RadioListTile(
                      title: Text(Major.CS.toString().split(".")[1]),
                      value: Major.CS,
                      groupValue: profile.major,
                      onChanged: con.onChangedMajor,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text(Major.SE.toString().split(".")[1]),
                      value: Major.SE,
                      groupValue: profile.major,
                      onChanged: con.onChangedMajor,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text(Major.Other.toString().split(".")[1]),
                      value: Major.Other,
                      groupValue: profile.major,
                      onChanged: con.onChangedMajor,
                    ),
                  ),
                ],
              ),
            ),
            Text("Classification"),
            DropdownButtonFormField(
              hint: Text("Classification"),
              value: profile.classification,
              onChanged: con.onChangedClassification,
              items: con.getClassificationList(),
              
            ),
          ],
        ),
      ),
    );
  }
}

class _Controller {
  _ProfileEditState _state;
  _Controller(this._state);

  String validatorName(String value) {
    if (value.length < 2) {
      return "min 2 chars";
    } else {
      return null;
    }
  }

  String validatorAge(String value) {
    try {
      int age = int.parse(value);
      if (age > 5)
        return null;
      else
        return "Required age > 5";
    } catch (e) {
      return "not an integer";
    }
  }

  void onSavedName(String value) {
    _state.profile.name = value;
  }

  void onSavedAge(String value) {
    _state.profile.age = int.parse(value);
  }

  void onChangedMajor(Major m){
    _state.render((){
      _state.profile.major = m;
      });
  }

  void onChangedClassification(Classification c){
    _state.profile.classification = c;
  }

  List getClassificationList(){
    return Classification.values.map((c) {
      return DropdownMenuItem(
        value: c,
        child: Text(c.toString().split(".")[1]),
      );
    }).toList();
  }
}
