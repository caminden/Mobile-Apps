import 'package:flutter/material.dart';

class CounterDemoScreen extends StatefulWidget {
  static const routeName = '/counterDemoScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CounterDemoState();
    //_ means private to this file
  }
}

class _CounterDemoState extends State<CounterDemoScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter Demo"),
      ),
      body: Column(
        children: <Widget>[
          Text("count is : $count"),
          RaisedButton.icon(
            onPressed: () {
              setState(() {
                ++count;
              });
            },
            icon: Icon(Icons.arrow_upward),
            label: Text("Increment"),
          ),
          RaisedButton.icon(
            onPressed: () {
              setState(() {
                --count;
              });
            },
            icon: Icon(Icons.arrow_downward),
            label: Text("Decrement"),
          )
        ],
      ),
    );
  }
}
