import 'package:flutter/material.dart';
import 'package:lesson2/screens/counterdemo_screen.dart';
import 'package:lesson2/screens/start_screen.dart';

void main() {
  runApp(lesson2App());
}

class lesson2App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Text("Lesson2"),
      initialRoute: StartScreen.routeName,
      routes: {
        StartScreen.routeName: (context) => StartScreen(), 
        CounterDemoScreen.routeName: (context) =>CounterDemoScreen(),
      },
    );
  }
}
