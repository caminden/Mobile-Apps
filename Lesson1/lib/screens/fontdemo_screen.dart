import 'package:flutter/material.dart';

class FontDemoScreen extends StatelessWidget {
  static const routeName = '/fontDemoScreen';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Font Demo"),
      ),
      body: Text("MAP Fall 2020",
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: 'IndieFlower',
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            letterSpacing: 2.0,
          )),
    );
  }
}
