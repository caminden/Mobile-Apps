import 'package:flutter/material.dart';

class NameCardScreen extends StatelessWidget {
  static const routeName = '/nameCardScreen';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/chase.jpg'),
                radius: 70.0,
              ),
            ),
            Divider(
              height: 20.0,
              color: Colors.yellow,
            ),
            Text('NAME', style: TextStyle(color: Colors.lightBlue)),
            Text('Chase Minden', style: TextStyle(color: Colors.lightBlue)),
            SizedBox(
              height: 10.0,
            ),
            Text('TITLE', style: TextStyle(color: Colors.lightBlue)),
            Text('Student at UCO', style: TextStyle(color: Colors.lightBlue)),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget> [
                Icon(Icons.email),
                SizedBox(width: 20.0),
                Text('cminden@uco.edu', ),
                
              ],
            ),
            SizedBox(height: 10.0,),
             Row(
              children: <Widget> [
                Icon(Icons.phone),
                SizedBox(width: 20.0),
                Text('580 606 1284', ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
