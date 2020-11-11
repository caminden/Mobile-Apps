import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routename = 'homeScreen';
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("HOme page"),
      ),
      body: Text("Body"),
    );
  }
}
