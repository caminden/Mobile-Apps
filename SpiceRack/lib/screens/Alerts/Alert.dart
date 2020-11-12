import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alert{
    static void send(BuildContext context, String title, String content){
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(title),
            content: Text(content),
          );
        }
      );
    }
}