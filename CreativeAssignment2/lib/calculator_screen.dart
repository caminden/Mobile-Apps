import 'package:CreativeAssignment2/history_screen.dart';
import 'package:flutter/material.dart';

import 'models/history.dart';

class CalculatorScreen extends StatefulWidget {
  static const routeName = '/calculatorScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CalculatorScreenState();
  }
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  _Controller con;
  String number = '0';

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
    return WillPopScope(
      onWillPop: () => Future.value(false), //disable back button, no use
      child: Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 100.0,
                alignment: Alignment.bottomRight,
                child: Text('$number', style: TextStyle(fontSize: 40.0)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  keyPad("1", () => con.setNum("1")),
                  keyPad("2", () => con.setNum("2")),
                  keyPad("3", () => con.setNum("3")),
                  keyPad("C", con.Clear),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  keyPad("4", () => con.setNum("4")),
                  keyPad("5", () => con.setNum("5")),
                  keyPad("6", () => con.setNum("6")),
                  keyPad("-", () => con.setAction(" - ")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  keyPad("7", () => con.setNum("7")),
                  keyPad("8", () => con.setNum("8")),
                  keyPad("9", () => con.setNum("9")),
                  keyPad("+", () => con.setAction(" + ")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonTheme(
                    height: 100.0,
                    minWidth: 100.0,
                    child: FlatButton(
                        color: Colors.grey[400],
                        onPressed: () => Navigator.pushNamed(
                            context, HistoryScreen.routeName),
                        child: Text(
                          "History",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )),
                  ),
                  keyPad("0", () => con.setNum("0")),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 100.0,
                    child: FlatButton(
                        color: Colors.grey[400],
                        onPressed: con.Equals,
                        child: Text(
                          "=",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}

//create easy sized buttons for a keypad
Widget keyPad(String input, Function fn) {
  return MaterialButton(
    onPressed: fn,
    height: 100.0,
    minWidth: 100.0,
    color: Colors.grey[400],
    child: Text(
      input,
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
  );
}

class _Controller {
  _CalculatorScreenState _state;
  _Controller(this._state);

  void Clear() {
    _state.render(() {
      _state.number = "0";
    });
  }

  void setNum(String s) {
    _state.render(() {
      if (_state.number == '0') {
        _state.number = s;
      } else {
        _state.number = _state.number + s;
      }
    });
  }

  void setAction(String s) {
    _state.render(() {
      if (_state.number == '0') {
      } else {
        _state.number = _state.number + s;
      }
    });
  }

  void Equals() {
    int temp1, temp2, finalNum;
    String action;

    History h = new History();
    h.equation = _state.number;
    
    if(_state.number.split(" ")[1] == null){
      _state.number = _state.number;
    }
    else{
    temp1 = int.parse(_state.number.split(" ")[0]);
    for (int i = 1; i < _state.number.split(" ").length; i += 2) {
      action = _state.number.split(" ")[i];
      temp2 = int.parse(_state.number.split(" ")[i + 1]);
      if (action == "+") {
        finalNum = temp1 + temp2;
      } else if (action == "-") {
        finalNum = temp1 - temp2;
      }else {
        finalNum = finalNum;
      }
      temp1 = finalNum;
    }
    }

    h.outcome = finalNum.toString();
    historyList.add(h);

    _state.render(() {
      _state.number = finalNum.toString();
    });
  }
}
