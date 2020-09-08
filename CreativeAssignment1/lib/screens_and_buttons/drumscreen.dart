import 'package:flutter/material.dart';

class DrumScreen extends StatelessWidget {
  static const routeName = '/drumScreen';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Drums"),
      ),
      body: Column(
        children: <Widget>[
          //start of symbol
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 200.0,
              width: 200.0,
              color: Colors.transparent,
              child: Align(
                alignment: Alignment(-0.5, 1),
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.yellow[600],
                  child: FlatButton(
                    padding: EdgeInsets.all(30.0),
                    onPressed: () => print("Symbol"),
                    color: Colors.transparent,
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.yellow[500],
                    ),
                  ),
                ),
              ),
            ),
          ),
          //start of 2 smaller drums
          Center(
            child: Wrap(
                spacing: 100.0,
              children: <Widget>[
                CircleAvatar(
                  radius: 70.0,
                  backgroundColor: Colors.brown[300],
                  child: FlatButton(
                    padding: EdgeInsets.all(10.0),
                    onPressed: () => print("Drum 3"),
                    color: Colors.transparent,
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundColor: Colors.brown[200],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 70.0,
                  backgroundColor: Colors.brown[300],
                  child: FlatButton(
                    padding: EdgeInsets.all(10.0),
                    onPressed: () => print("Drum 4"),
                    color: Colors.transparent,
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundColor: Colors.brown[200],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //start of last drum set
          Center(
            child: Wrap(
                spacing: 10.0,
              children: <Widget>[
                CircleAvatar(
                  radius: 85.0,
                  backgroundColor: Colors.brown[300],
                  child: FlatButton(
                    padding: EdgeInsets.all(10.0),
                    onPressed: () => print("Drum 1"),
                    color: Colors.transparent,
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundColor: Colors.brown[200],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 85.0,
                  backgroundColor: Colors.brown[300],
                  child: FlatButton(
                    padding: EdgeInsets.all(10.0),
                    onPressed: () => print("Drum 2"),
                    color: Colors.transparent,
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundColor: Colors.brown[200],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
