import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  static const routeName = 'signInScreen/homeScreen';
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }

}

class _HomeScreenState extends State<HomeScreen>{
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
        title: Text("Home"),
      ),
      body: Text("demo"),
    );
  }

}

class _Controller{
  _HomeScreenState _state;
  _Controller(this._state);
}