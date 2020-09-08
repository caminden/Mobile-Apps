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
      body: Center(
        child: Container(
          height: 50.0,
          width: 50.0,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.yellow,
              ),
              CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
