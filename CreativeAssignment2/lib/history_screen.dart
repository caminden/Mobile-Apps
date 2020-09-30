import 'package:flutter/material.dart';

import 'models/history.dart';

class HistoryScreen extends StatefulWidget{
  static const routeName = '/historyScreen';
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HistoryScreenState();
  }

}

class _HistoryScreenState extends State<HistoryScreen>{
  _Controller con;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  void render(fn){
    setState(fn);
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: con.deleteHistory,
          )
        ],
        title: Text("History"),
      ),
      body: ListView.builder(
        itemCount: historyList.length,
        itemBuilder: con.getHistoryList,
      )
    );
  }
}

class _Controller{
  _HistoryScreenState _state;
  _Controller(this._state);

  Widget getHistoryList(BuildContext context, int index){
    return Container(
      color: Colors.grey[500],
      padding: EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(historyList[index].equation),
        subtitle: Text(historyList[index].outcome),
      )
    );
  }

  void deleteHistory(){
    _state.render((){
      historyList.removeRange(0, historyList.length);
    });
  }
}