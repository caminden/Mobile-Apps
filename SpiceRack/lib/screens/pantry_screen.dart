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
        centerTitle: true,
        title: Text("Pantry"),
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
                            Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "${pantry.items[index]}",
                                  style: TextStyle(fontSize: 20),
                                )),
                            Container(
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

  void addToPantry() async {
    await Navigator.pushNamed(_state.context, AddPantry.routeName, arguments: {
      'user': _state.user,
      'pantry': _state.pantry,
    });
    _state.render(() {});
  }
}
