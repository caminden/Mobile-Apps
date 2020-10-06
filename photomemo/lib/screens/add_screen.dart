import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget{
  static const routeName = '/home/addScreen';
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddState();
  }

}

class _AddState extends State<AddScreen>{
  _Controller con;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }
  
  @override
  Widget build(BuildContext context) {
    //ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
        ),
        body: Text("Test"),
    );
  }

}

class _Controller{
  _AddState _state;
  _Controller(this._state);
}