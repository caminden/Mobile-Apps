import 'package:flutter/material.dart';

class ExpandedDemoScreen extends StatelessWidget {
  static const routeName = '/expandedDemoScreen';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Expanded Widget Demo'),
      ),
      body: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(child: Text('A'), color: Colors.red[200])),
              Expanded(
                flex: 1,
                child: Image.asset('images/car.jpg'),
              ),
              Expanded(
                flex: 2,
                child: Text('B'),
              ),
            ],
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Text('AA'),
              color: Colors.red[300],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text('BB'),
              color: Colors.teal[300],
            ),
          ),
        ],
      ),
    );
  }
}
