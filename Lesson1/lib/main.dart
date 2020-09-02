import 'package:flutter/material.dart';
import 'package:lesson1/screens/buttondemo_screen.dart';
import 'package:lesson1/screens/expandeddemo_screen.dart';
import 'package:lesson1/screens/fontdemo_screen.dart';
import 'package:lesson1/screens/imagedemo_screen.dart';
import 'package:lesson1/screens/namecard_screen.dart';
import 'package:lesson1/screens/rowcolumndemo_screen.dart';
import 'package:lesson1/screens/startscreen.dart';

void main() {
  runApp(Lesson1App());
}

class Lesson1App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Done: Implement Build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red[500],
        accentColor: Colors.yellow[500],
        fontFamily: 'Monospace',
        textTheme: TextTheme(
          headline5: TextStyle(fontSize: 72.0),
          headline6: TextStyle(fontSize: 36.0),
          bodyText1: TextStyle(fontSize: 20.0),
          bodyText2: TextStyle(fontSize: 14.0),
        ),
      ),
      initialRoute: StartScreen.routeName,
      routes: {
        StartScreen.routeName: (context) => StartScreen(),
        ImageDemoScreen.routeName: (context) => ImageDemoScreen(),
        ButtonDemoScreen.routeName: (context) => ButtonDemoScreen(),
        FontDemoScreen.routeName: (context) => FontDemoScreen(),
        RowColumnDemoScreen.routeName: (context) => RowColumnDemoScreen(),
        ExpandedDemoScreen.routeName: (conext) => ExpandedDemoScreen(),
        NameCardScreen.routeName: (context) => NameCardScreen(),
      },
    );
  }
}
