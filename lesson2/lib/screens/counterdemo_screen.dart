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
  _Controller con;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  void render(fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
                child: Text("count is : $count",
                    style: TextStyle(fontSize: 30.0))),
            RaisedButton.icon(
              onPressed: con.IncrementCounter,
              icon: Icon(Icons.arrow_upward),
              label: Text("Increment",
                  style: TextStyle(fontSize: 20.0, color: Colors.teal)),
              color: Colors.amber,
            ),
            RaisedButton.icon(
              onPressed: con.DecrementCounter,
              icon: Icon(Icons.arrow_downward),
              label: Text("Decrement",
                  style: TextStyle(fontSize: 20.0, color: Colors.red)),
            )
          ],
        ),
      ),
    );
  }
}

class _Controller {
  _CounterDemoState _state;
  _Controller(this._state);

  void IncrementCounter() {
    _state.render(() {
      ++_state.count;
    });
  }

  void DecrementCounter() {
    _state.render(() {
      --_state.count;
    });
  }
}
