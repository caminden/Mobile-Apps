import 'package:flutter/material.dart';
import 'package:lesson2/model/course.dart';

class ListDemoScreen extends StatefulWidget{
  
  static const routeName = '/listDemoScreen';
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListDemoState();
  }

}

class _ListDemoState extends State<ListDemoScreen> {
  _Controller con;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("List Demo"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: con.getCourseList(),
        ),
      ),
    );
  }

}

class _Controller {
  _ListDemoState _state;
  _Controller(this._state);

  List<Widget> getCourseList(){
    return courseList.map((course){
      return Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        color: Colors.lime[400],
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Row(
              children: <Widget>[
                Image.network(course.imageUrl, width: 200.0,),
                SizedBox(width: 15.0,),
                Text(course.number, style: TextStyle(fontSize: 20.0)),
              ],
            ),
            Text(course.title, style: TextStyle(fontSize: 20.0)),
            Row(
              children: <Widget> [
                Text('Prereq'),
                SizedBox(width: 20.0,),
                Text(course.prereq),
              ]
            )
          ],
        ),
      );
    }).toList();
  }
}