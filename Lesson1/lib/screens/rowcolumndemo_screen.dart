import 'package:flutter/material.dart';

class RowColumnDemoScreen extends StatelessWidget {
  static const routeName = '/rowColumnDemoScreen';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Row/Column'),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text('One'),
                color: Colors.blue[200],
                padding: EdgeInsets.all(20.0),
              ),
              Wrap(
                spacing: 15.0,
                runSpacing: 8.0,
                children: <Widget>[
                  Container(
                    child: Text('Two-1'),
                    color: Colors.blue[600],
                    padding: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Two-2'),
                    color: Colors.blue[600],
                    padding: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Two-3'),
                    color: Colors.blue[600],
                    padding: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Two-4'),
                    color: Colors.blue[600],
                    padding: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Two-5'),
                    color: Colors.blue[600],
                    padding: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text('Two-6'),
                    color: Colors.blue[600],
                    padding: EdgeInsets.all(20.0),
                  ),
                ],
              ),
              Container(
                child: Text('Three'),
                padding: EdgeInsets.all(20.0),
                color: Colors.blue[900],
              ),
              Row(
                children: <Widget>[
                  Expanded(child: Image.network('https://m.media-amazon.com/images/I/81eYsRfvMBL._AC_UL320_.png')),
                  Expanded(child: Image.asset('images/car.jpg')),
                ],
              ),
            ]),
      ),
    );
  }
}
