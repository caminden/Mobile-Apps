import 'package:SpiceRack/controller/firebasecontroller.dart';
import 'package:SpiceRack/screens/Alerts/Alert.dart';
import 'package:SpiceRack/screens/Models/pantry.dart';
import 'package:SpiceRack/screens/pantry_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPantry extends StatefulWidget {
  static const routeName = '/Pantry/addPantry';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPantryState();
  }
}

class _AddPantryState extends State<AddPantry> {
  _Controller con;
  var formKey = GlobalKey<FormState>();
  int repeat = 1;
  User user;
  Pantry pantry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    //print(repeat);
    Map map = ModalRoute.of(context).settings.arguments;
    user ??= map['user'];
    pantry ??= map['pantry'];
    return Scaffold(
      bottomNavigationBar: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                //print("Before add: $repeat");
                render(() {
                  repeat++;
                });
                //print("After add: $repeat");
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                //print("Before sub: $repeat");
                if (repeat > 1) {
                  render(() {
                    repeat--;
                  });
                }
                //print("After sub: $repeat");
              },
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text("Add Items to Pantry"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/page.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: ListView.builder(
              itemCount: repeat,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "name",
                          ),
                          autocorrect: true,
                          textAlign: TextAlign.center,
                          validator: con.validateName,
                          onSaved: con.saveName,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Quantity",
                          ),
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          validator: con.validateQuantity,
                          onSaved: con.saveQuantity,
                        ),
                      ),
                      /*Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: RaisedButton(
                          onPressed: () => con._selectDate(context, index), // Refer step 3
                          child: Text(
                            'Expires',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          color: Colors.brown[50],
                        ),
                      ),*/ //for expring date, need to fix
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.brown[100],
        ),
        child: IconButton(
          icon: Icon(Icons.check),
          onPressed: con.save,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _Controller {
  _AddPantryState _state;
  _Controller(this._state);
  List<String> name = [];
  List<int> quantity = [];

  void save() async {
    if (!_state.formKey.currentState.validate()) {
      return;
    }
    _state.formKey.currentState.save();

    try {
      var p = Pantry(
        owner: _state.user.email,
        items: name,
        quantity: quantity,
      );

      p.docID = await FireBaseController.addPantryItems(p);
      Navigator.pop(_state.context);
      _state.pantry.items += name;
      _state.pantry.quantity += quantity;
      Alert.send(_state.context, "Added to Pantry", "Success");
    } catch (e) {
      Alert.send(_state.context, "Pantry error", e.message);
    }
  }

  //validators
  String validateName(String s) {
    if (s.isEmpty) {
      return "Name cannot be empty";
    }
    return null;
  }

  String validateQuantity(String s) {
    if (s.isEmpty) {
      return "Please input a #";
    }
    int i = int.parse(s);
    if (i <= 0) {
      return "Number cannot be 0 or less";
    }
    return null;
  }

  void saveName(String s) {
    String c = s.substring(0, 1);
    c = c.toUpperCase();
    String b = s.substring(1);
    b = b.toLowerCase();
    s = c + b;
    this.name.add(s);
  }

  void saveQuantity(String s) {
    int i = int.parse(s);
    this.quantity.add(i);
  }
}
