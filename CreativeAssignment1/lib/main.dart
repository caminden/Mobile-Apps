import 'package:CreativeAssignment1/screens_and_buttons/drumscreen.dart';
import 'package:CreativeAssignment1/screens_and_buttons/homescreen.dart';
import 'package:CreativeAssignment1/screens_and_buttons/pianoscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        PianoScreen.routeName: (context) => PianoScreen(),
        DrumScreen.routeName: (context) => DrumScreen(),
      },
    );
  }
}



