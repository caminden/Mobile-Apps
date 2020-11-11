import 'package:SpiceRack/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(SpiceRack());
}

class SpiceRack extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
      },
    ); 
  }
}