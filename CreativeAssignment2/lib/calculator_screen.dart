import 'package:flutter/material.dart';

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
              height: 70.0,
              alignment: Alignment.bottomRight,
              child: Text("0", style: TextStyle(fontSize: 40.0)),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                keyPad("1", (){}),
                keyPad("2", (){}),
                keyPad("3", (){}),
                keyPad("C", (){}),
              ],
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                keyPad("4", (){}),
                keyPad("5", (){}),
                keyPad("6", (){}),
                keyPad("=", (){}),
              ],
              ),
               Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                keyPad("7", (){}),
                keyPad("8", (){}),
                keyPad("9", (){}),
                keyPad("+", (){}),
              ],
              ),
               Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                keyPad("*", (){}),
                keyPad("0", (){}),
                keyPad("/", (){}),
                keyPad("-", (){}),
              ],
              )
          ]
        ),
        
      ),
    );
  }
}

//create easy sized buttons for a keypad 
Widget keyPad(String input, Function fn){
  return MaterialButton(
    onPressed: fn,
    height: 100.0,
    minWidth: 100.0,
    color: Colors.grey[400],
    child: Text(input, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
  );
}

class _Controller {
  _CalculatorScreenState _state;
  _Controller(this._state);
}
