import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

class PianoScreen extends StatelessWidget {
  static const routeName = '/pianoScreen';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Piano'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: RaisedButton(
              onPressed: () => print("1"),
              child: null,
              padding: EdgeInsets.fromLTRB(1, 1, 200, 1),
              color: Colors.white,
            ),
            color: Colors.grey[300],
          ),
          Row(
            children: [
              Container(
                child: RaisedButton(
                  onPressed: () => print("2.1"),
                  child: null,
                  padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                  color: Colors.black,
                ),
                color: Colors.grey[300],
              ),
              Container(
                child: RaisedButton(
                  onPressed: () => print("2"),
                  child: null,
                  padding: EdgeInsets.fromLTRB(1, 1, 112, 1),
                  color: Colors.white,
                ),
                color: Colors.grey[300],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: RaisedButton(
                  onPressed: () => print("3.1"),
                  child: null,
                  padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                  color: Colors.black,
                ),
                color: Colors.grey[300],
              ),
              Container(
                child: RaisedButton(
                  onPressed: () => print("3"),
                  child: null,
                  padding: EdgeInsets.fromLTRB(1, 1, 112, 1),
                  color: Colors.white,
                ),
                color: Colors.grey[300],
              ),
            ],
          ),
          Container(
            child: RaisedButton(
              onPressed: () => print("4"),
              child: null,
              padding: EdgeInsets.fromLTRB(1, 1, 200, 1),
              color: Colors.white,
            ),
            color: Colors.grey[300],
          ),
          Row(
            children: [
              Container(
                child: RaisedButton(
                  onPressed: () => print("5.1"),
                  child: null,
                  padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                  color: Colors.black,
                ),
                color: Colors.grey[300],
              ),
              Container(
                child: RaisedButton(
                  onPressed: () => print("5"),
                  child: null,
                  padding: EdgeInsets.fromLTRB(1, 1, 112, 1),
                  color: Colors.white,
                ),
                color: Colors.grey[300],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: RaisedButton(
                  onPressed: () => print("6.1"),
                  child: null,
                  padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                  color: Colors.black,
                ),
                color: Colors.grey[300],
              ),
              Container(
                child: RaisedButton(
                  onPressed: () => print("6"),
                  child: null,
                  padding: EdgeInsets.fromLTRB(1, 1, 112, 1),
                  color: Colors.white,
                ),
                color: Colors.grey[300],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: RaisedButton(
                  onPressed: () => print("7.1"),
                  child: null,
                  padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                  color: Colors.black,
                ),
                color: Colors.grey[300],
              ),
              Container(
                child: RaisedButton(
                  onPressed: () => print("7"),
                  child: null,
                  padding: EdgeInsets.fromLTRB(1, 1, 112, 1),
                  color: Colors.white,
                ),
                color: Colors.grey[300],
              ),
            ],
          ),
          Container(
            child: RaisedButton(
              onPressed: () => print("8"),
              child: null,
              padding: EdgeInsets.fromLTRB(1, 1, 200, 1),
              color: Colors.white,
            ),
            color: Colors.grey[300],
          ),
          Container(
            child: RaisedButton(
              onPressed: () => print("9"),
              child: null,
              padding: EdgeInsets.fromLTRB(1, 1, 200, 1),
              color: Colors.white,
            ),
            color: Colors.grey[300],
          ),
          Row(
            children: [
              Container(
                child: RaisedButton(
                  onPressed: () => print("10.1"),
                  child: null,
                  padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                  color: Colors.black,
                ),
                color: Colors.grey[300],
              ),
              Container(
                child: RaisedButton(
                  onPressed: () => print("10"),
                  child: null,
                  padding: EdgeInsets.fromLTRB(1, 1, 112, 1),
                  color: Colors.white,
                ),
                color: Colors.grey[300],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: RaisedButton(
                  onPressed: () => print("11.1"),
                  child: null,
                  padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                  color: Colors.black,
                ),
                color: Colors.grey[300],
              ),
              Container(
                child: RaisedButton(
                  onPressed: () => print("11"),
                  child: null,
                  padding: EdgeInsets.fromLTRB(1, 1, 112, 1),
                  color: Colors.white,
                ),
                color: Colors.grey[300],
              ),
            ],
          ),
          Container(
            child: RaisedButton(
              onPressed: () => print("12"),
              child: null,
              padding: EdgeInsets.fromLTRB(1, 1, 200, 1),
              color: Colors.white,
            ),
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
