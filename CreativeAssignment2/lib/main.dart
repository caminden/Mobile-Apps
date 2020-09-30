import 'package:CreativeAssignment2/calculator_screen.dart';
import 'package:CreativeAssignment2/history_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CreativeApp2());
}

class CreativeApp2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Text("Creative App"),
      theme: ThemeData.dark(),
      initialRoute: CalculatorScreen.routeName,
      routes: {
      CalculatorScreen.routeName: (context) => CalculatorScreen(),
      HistoryScreen.routeName: (context) => HistoryScreen(),
      }
    );
  }

}
