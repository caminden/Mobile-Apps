import 'package:SpiceRack/screens/addpantry_screen.dart';
import 'package:SpiceRack/screens/addrecipe_screen.dart';
import 'package:SpiceRack/screens/detail_screen.dart';
import 'package:SpiceRack/screens/editrecipe_screen.dart';
import 'package:SpiceRack/screens/home_screen.dart';
import 'package:SpiceRack/screens/login_screen.dart';
import 'package:SpiceRack/screens/pantry_screen.dart';
import 'package:SpiceRack/screens/recipebook_screen.dart';
import 'package:SpiceRack/screens/settings_screen.dart';
import 'package:SpiceRack/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(SpiceRack());
}

class SpiceRack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.brown[50],
        canvasColor: Colors.brown[50],
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routename: (context) => HomeScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        RecipeBook.routeName: (context) => RecipeBook(),
        AddRecipe.routeName: (context) => AddRecipe(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
        DetailedRecipe.routeName: (context) => DetailedRecipe(),
        PantryScreen.routeName: (conetxt) => PantryScreen(),
        AddPantry.routeName: (context) => AddPantry(),
        EditRecipe.routeName: (context) => EditRecipe(),
      },
    );
  }

  
}


