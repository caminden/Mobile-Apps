import 'package:SpiceRack/controller/firebasecontroller.dart';
import 'package:SpiceRack/screens/Models/pantry.dart';
import 'package:SpiceRack/screens/addpantry_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PantryScreen extends StatefulWidget {
  static const routeName = '/homeScreen/pantryScreen';

  @override
  State<StatefulWidget> createState() {
    return _PantryState();
  }
}

class _PantryState extends State<PantryScreen> {
  _Controller con;
  User user;
  Pantry pantry;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    Map map = ModalRoute.of(context).settings.arguments;
    user ??= map['user'];
    pantry ??= map['pantry'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantry"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            width: 150.0,
            child: Form(
              key: formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search Items",
                  fillColor: Colors.white,
                  filled: true,
                ),
                autocorrect: false,
                onSaved: con.onSaveSearchKey,
              ),
            ),
          ),
          con.delIndex == null
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: con.search,
                )
              : IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: con.delete,
                ),
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
        child: pantry == null
            ? Text("No items in pantry")
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "ITEMS",
                          style: TextStyle(
                              fontSize: 30,
                              decoration: TextDecoration.overline),
                        ),
                      ),
                      Container(
                        child: Text(
                          "QUANTITY",
                          style: TextStyle(
                              fontSize: 30,
                              decoration: TextDecoration.overline),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: pantry.items.length,
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => con.onTap(index),
                              onLongPress: () => con.addDeleteIndex(index),
                              child: Container(
                                  color: con.delIndex == index
                                      ? Colors.red
                                      : Colors.transparent,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "${pantry.items[index]}",
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ),
                            Container(
                                color: con.delIndex == index
                                    ? Colors.red
                                    : Colors.transparent,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "${pantry.quantity[index]}",
                                  style: TextStyle(fontSize: 20),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.brown[100],
        ),
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: con.addToPantry,
        ),
      ),
    );
  }
}

class _Controller {
  _PantryState _state;
  _Controller(this._state);
  int delIndex;
  String searchKey;

  void addToPantry() async {
    await Navigator.pushNamed(_state.context, AddPantry.routeName, arguments: {
      'user': _state.user,
      'pantry': _state.pantry,
    });
    _state.render((){});
  }

  void onSaveSearchKey(String s) {
    searchKey = s;
  }

  void search() async {
    _state.formKey.currentState.save();
    Pantry result = new Pantry();
    if (searchKey == null || searchKey.trim().isEmpty) {
      result = await FireBaseController.loadPantryItems(_state.user.email);
    } else {
      String c = searchKey.substring(0, 1);
      c = c.toUpperCase();
      String b = searchKey.substring(1);
      b = b.toLowerCase();
      searchKey = c + b;
      Pantry original =
          await FireBaseController.loadPantryItems(_state.user.email);
      for (int i = 0; i < original.items.length; i++) {
        if (original.items[i].contains(searchKey)) {
          result.items.add(original.items[i]);
          result.quantity.add(original.quantity[i]);
        }
      }
    }
    _state.render(() => _state.pantry = result);
  }

  void addDeleteIndex(int index) {
    _state.render(() {
      delIndex = (delIndex == index ? null : index);
    });
  }

  void onTap(int index) async {
    if (delIndex != null) {
      _state.render(() => delIndex = null);
    }
  }

  void delete() async {
    try {
      if (_state.pantry.items.length == 1) {
        await FireBaseController.deletePantry(_state.pantry);
      } else {
        await FireBaseController.removePantryItems(_state.pantry, delIndex);
      }
      _state.render(() {
        _state.pantry.items.removeAt(delIndex);
        _state.pantry.quantity.removeAt(delIndex);
        delIndex = null;
      });
    } catch (e) {}
  }
}
