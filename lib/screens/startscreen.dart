import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  static const routeName = '/startScreen';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Screen'),
      ),
      body: Column(children: <Widget>[
        RaisedButton(
          child: Text('Image Demo'),
          onPressed: () {
            print('image demo button');
          },
        ),
        RaisedButton.icon(
          onPressed: (){print('button demo');},
          icon: Icon(Icons.ac_unit, color: Colors.red),
          label: Text('Button demo'),
        )
      ]),
    );
  }
}
