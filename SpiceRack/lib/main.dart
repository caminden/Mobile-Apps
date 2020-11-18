import 'package:SpiceRack/screens/addrecipe_screen.dart';
import 'package:SpiceRack/screens/home_screen.dart';
import 'package:SpiceRack/screens/login_screen.dart';
import 'package:SpiceRack/screens/recipebook_screen.dart';
import 'package:SpiceRack/screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(SpiceRack());
}

class SpiceRack extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.brown[50],
        canvasColor: Colors.brown[50],
        
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routename: (context) => HomeScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        RecipeBook.routeName: (context) => RecipeBook(),
        AddRecipe.routeName: (context) => AddRecipe(),
      },
    ); 
  }
}