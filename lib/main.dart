import 'package:flutter/material.dart';
import 'package:lesson1/screens/buttondemo_screen.dart';
import 'package:lesson1/screens/imagedemo_screen.dart';
import 'package:lesson1/screens/startscreen.dart';

void main() {
  runApp(Lesson1App());
}

class Lesson1App extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // Done: Implement Build
    return MaterialApp(
      initialRoute: StartScreen.routeName,
      routes: {
      StartScreen.routeName: (context) => StartScreen(),
      ImageDemoScreen.routeName: (context) => ImageDemoScreen(),
      ButtonDemoScreen.routeName: (context) => ButtonDemoScreen(),
      },
    );
  }

}