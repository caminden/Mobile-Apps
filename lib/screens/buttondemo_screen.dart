import 'package:flutter/material.dart';

class ButtonDemoScreen extends StatelessWidget {
  static const routeName = '/buttonDemoScreen';
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Button Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Floating Action Button is pressed'),
        child: Icon(Icons.add),
        backgroundColor: Colors.red[200],
      ),
      body: Column(children: <Widget>[
        RaisedButton(
          onPressed: () {
            print('raised button is pressed');
          },
          elevation: 10.0,
          child: Text('Raised Button 1'),
          color: Colors.blue[900],
          textColor: Colors.white,
          splashColor: Colors.blue[100],
          padding: EdgeInsets.only(bottom: 10.0, top: 5.0),
        ),
        RaisedButton.icon(
          onPressed: () => print('Raised Button 2 is pressed'),
          icon: Icon(Icons.book, color: Colors.red),
          label: Text('Raised Button 2'),
        ),
        FlatButton(
          onPressed: () => print('Flat Button is pressed'),
          child: Text(
            'Flat Button',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          color: Colors.teal[900],
          splashColor: Colors.teal[100],
        ),
        IconButton(
          icon: Icon(Icons.broken_image, size: 70.0, color: Colors.blue),
          onPressed: () => print('Icon Button is pressed'),
        )
      ]),
    );
  }
}
