import 'package:flutter/material.dart';
import 'package:lesson2/screens/counterdemo_screen.dart';
import 'package:lesson2/screens/formdemoscreen.dart';
import 'package:lesson2/screens/listdemo_screen.dart';
import 'package:lesson2/screens/profiledemo_screen.dart';
import 'package:lesson2/screens/taponlist_screen.dart';
import 'package:lesson2/screens/widgetlifecycle_screen.dart';

class StartScreen extends StatelessWidget {
  static const routeName = '/startScreen';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Start Menu"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, CounterDemoScreen.routeName),
              child: Text("Counter Demo"),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, WidgetLifeCycle.routeName),
              child: Text("Widget Life Cycle Demo"),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, ListDemoScreen.routeName),
              child: Text("List Demo"),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, TapOnListScreen.routeName),
              child: Text("Tap On List Demo"),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, FormDemoScreen.routeName),
              child: Text("Form Demo"),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, ProfileDemoScreen.routeName),
              child: Text("Profile Edit Demo"),
            ),
          ],
        ),
      ),
    );
  }
}
