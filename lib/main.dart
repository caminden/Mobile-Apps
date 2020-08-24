import 'package:flutter/material.dart';
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
      StartScreen.routeName: (BuildContext context){ return StartScreen();},
      },
    );
  }

}