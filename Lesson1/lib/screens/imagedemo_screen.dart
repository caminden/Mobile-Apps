import 'package:flutter/material.dart';

class ImageDemoScreen extends StatelessWidget {
  static const routeName = '/imageDemoScreen';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Image demo'),
      ),
      body: ListView(children: <Widget>[
        Container(
            color: Colors.blue,
            height: 200.0,
            child: Image.network(
                'https://m.media-amazon.com/images/I/61+yXZNrLEL._AC_UL320_.jpg')),
        Icon(
          Icons.battery_alert,
          color: Colors.red,
          size: 100.0,
        ),
        Container(
          height: 300.0,
          child: Image.network(
              'https://m.media-amazon.com/images/I/910v4qEX8SL._AC_UL320_.jpg'),
        ),
        Container(
          height: 200.0,
          color: Colors.teal,
          child: Image.asset('images/car.jpg'),
        ),
      ]),
    );
  }
}
