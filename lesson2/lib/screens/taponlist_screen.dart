import 'package:flutter/material.dart';
import 'package:lesson2/model/course.dart';

class TapOnListScreen extends StatefulWidget {
  static const routeName = '/tapOnListScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TapOnListState();
  }
}

class _TapOnListState extends State<TapOnListScreen> {
  _Controller con;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Tap On List"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: con.delete,
            )
          ],
        ),
        body: ListView.builder(
          itemCount: courseList.length,
          itemBuilder: con.getListTile,
        ));
  }
}

class _Controller {
  _TapOnListState _state;
  _Controller(this._state);

  Widget getListTile(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      color:
          courseList[index].selected ? Colors.indigo[400] : Colors.indigo[200],
      child: ListTile(
        title: Text(courseList[index].number),
        subtitle: Text(courseList[index].title),
        onTap: () => _onTap(context, index),
        onLongPress: () => _onLongPress(context, index),
      ),
    );
  }

  void _onLongPress(BuildContext context, int index) {
    _state.render(() {
      courseList[index].selected = !courseList[index].selected;
    });
  }

  void delete(){
    _state.render (() => courseList.removeWhere((course) => course.selected));
  }

  void _onTap(BuildContext context, int index) async {
    await showDialog(
      context: context,
      barrierDismissible: false, //not dimissed until action
      builder: (context) => AlertDialog(
        title: Text(courseList[index].number),
        backgroundColor: Colors.grey[200],
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Close",
              style: TextStyle(fontSize: 30.0),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
        content: Card(
            color: Colors.indigo[200],
            elevation: 15.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(child: Image.network(courseList[index].imageUrl)),
                  Text(
                    courseList[index].title,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text('Prerequesite: ${courseList[index].prereq}'),
                ],
              ),
            )),
      ),
    );
  }
}
