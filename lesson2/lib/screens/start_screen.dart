import 'package:flutter/material.dart';
import 'package:lesson2/screens/counterdemo_screen.dart';
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
          children: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, CounterDemoScreen.routeName),
              child: Text("Counter Demo"),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, WidgetLifeCycle.routeName),
              child: Text("Widget Life Cycle Demo"),
            )
          ],
        ),
      ),
    );
  }
}
