import 'package:flutter/material.dart';

class DrumScreen extends StatelessWidget {
  static const routeName = '/drumScreen';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Drums"),
      ),
      body: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        runSpacing: 50.0,
        spacing: 50.0,
        children: <Widget>[
        Container(
          color: Colors.yellow,
          padding: EdgeInsets.fromLTRB(50, 1, 1, 50),
          child: Text("1")
        ),
        Container(
          color: Colors.yellow,
          padding: EdgeInsets.fromLTRB(50, 1, 1, 50),
          child: Text("2"),
        ),
      ]),
    );
  }
}
