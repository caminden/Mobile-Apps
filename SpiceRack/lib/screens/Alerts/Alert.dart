import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alert {
  static void send(BuildContext context, String title, String content) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
          );
        });
  }

  static void circularProgressStart(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
  }

  static void circularProgressEnd(BuildContext context){
    Navigator.pop(context);
  }
}
