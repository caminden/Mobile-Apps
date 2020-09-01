import 'package:flutter/material.dart';
import 'package:lesson1/screens/buttondemo_screen.dart';
import 'package:lesson1/screens/expandeddemo_screen.dart';
import 'package:lesson1/screens/fontdemo_screen.dart';
import 'package:lesson1/screens/imagedemo_screen.dart';
import 'package:lesson1/screens/rowcolumndemo_screen.dart';

class StartScreen extends StatelessWidget {
  static const routeName = '/startScreen';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
        RaisedButton(
          child: Text('Image Demo'),
          onPressed: () =>
              Navigator.pushNamed(context, ImageDemoScreen.routeName),
        ),
        RaisedButton.icon(
          onPressed: () =>
              Navigator.pushNamed(context, ButtonDemoScreen.routeName),
          icon: Icon(Icons.ac_unit, color: Colors.red),
          label: Text('Button demo'),
        ),
        RaisedButton.icon(
          onPressed: () =>
              Navigator.pushNamed(context, FontDemoScreen.routeName),
          icon: Icon(Icons.font_download, color: Colors.red[900]),
          label: Text('Font demo'),
        ),
        RaisedButton.icon(
          onPressed: () =>
              Navigator.pushNamed(context, RowColumnDemoScreen.routeName),
          icon: Icon(Icons.router, color: Colors.red[900]),
          label: Text('row/column demo'),
        ),
        RaisedButton.icon(
          onPressed: () =>
              Navigator.pushNamed(context, ExpandedDemoScreen.routeName),
          icon: Icon(Icons.router, color: Colors.red[900]),
          label: Text('Expanded widget demo'),
        ),
      ]),
    );
  }
}
