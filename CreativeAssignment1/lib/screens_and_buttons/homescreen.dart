import 'package:CreativeAssignment1/screens_and_buttons/drumscreen.dart';
import 'package:CreativeAssignment1/screens_and_buttons/pianoscreen.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text('Home',
              style: TextStyle(
                fontSize: 20.0,
              )),
          actions: [Icon(Icons.location_on), Icon(Icons.wifi)]),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Meet the creators!',
                style: TextStyle(
                  fontSize: 24.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: Text('1'),
              title: Text('Chase Minden'),
            ),
            ListTile(
              leading: Text('2'),
              title: Text('Chase Minden 1'),
            ),
            ListTile(
              leading: Text('3'),
              title: Text('Chase Minden 2'),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://cdn.vox-cdn.com/thumbor/0fPNabFt96yEmvSfyr7cHHZdjbw=/1400x1050/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/13292797/acastro_181016_1777_music_0001.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: RaisedButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, PianoScreen.routeName),
                icon: Icon(Icons.music_video, color: Colors.black),
                label: Text("Piano", style: TextStyle(color: Colors.black)),
                color: Colors.white,
              ),
            ),
            Center(
              child: RaisedButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, DrumScreen.routeName),
                icon: Icon(Icons.blur_circular, color: Colors.black),
                label: Text("Drums", style: TextStyle(color: Colors.black)),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
