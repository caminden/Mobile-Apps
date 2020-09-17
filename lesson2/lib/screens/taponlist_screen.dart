import 'package:flutter/material.dart';

class TapOnListScreen extends StatefulWidget{
  static const routeName = '/tapOnListScreen';
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TapOnListScreen();
  }

}

class _TapOnListScreen extends State<TapOnListScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Tap On List"),

      ),
      body: Text("body"),
    );
  }

}