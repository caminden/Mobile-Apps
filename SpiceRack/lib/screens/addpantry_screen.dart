import 'package:flutter/material.dart';

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
        title: Text("Add Items to Pantry"),
        centerTitle: true,
      ),
      body: Form(
        child: SingleChildScrollView(

        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.brown[100],
        ),
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}

class _Controller{
  _AddPantryState _state;
  _Controller(this._state);
}
