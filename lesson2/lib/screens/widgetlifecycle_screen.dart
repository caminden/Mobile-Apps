import 'package:flutter/material.dart';

class WidgetLifeCycle extends StatefulWidget {
  static const routeName = '/widgetLifecycle';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WidgetLifeCyclestate();
  }
}

class _WidgetLifeCyclestate extends State<WidgetLifeCycle> {
  int count = 0;
  _Controller con;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
    print('************ initState()');
    print('            == e.g., GPS listener, Camera controller');
  }

  void render(fn) {
    setState(fn);
  }

  @override
  void dispose() {
    print('************ dispose()');
    print('            == e.g., GPS listener, Camera controller');
    super.dispose();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    print('************ build()');
    return Scaffold(
      appBar: AppBar(
        title: Text("Widget Life Cycle"),
      ),
      body: Column(
        children: <Widget>[
          Text(count.toString()),
          RaisedButton(
            onPressed: con.buttonPressed,
            child: Text("Increase"),
          ),
        ],
      ),
    );
  }
}

class _Controller {
  _WidgetLifeCyclestate _state;
  _Controller(this._state);
  void buttonPressed() {
    _state.render(() {
      ++_state.count;
    });
  }
}
