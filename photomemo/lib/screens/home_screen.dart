import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photomemo/controller/firebasecontroller.dart';
import 'package:photomemo/model/photomemo.dart';
import 'package:photomemo/screens/add_screen.dart';
import 'package:photomemo/screens/signin_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'signInScreen/homeScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  _Controller con;
  FirebaseUser user;
  List<PhotoMemo> photoMemos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    user ??= args['user'];
    photoMemos ??= args['photoMemoList'];

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(user.email),
              accountName: Text(user.displayName ?? "N/A"),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Sign out"),
              onTap: con.signOut,
            )
          ],
        ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: con.addButton,
        ),
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: photoMemos.length == 0
            ? Text("No Photo Memos", style: TextStyle(fontSize: 30.0))
            : ListView.builder(
                itemCount: photoMemos.length,
                itemBuilder: (BuildContext context, int index) => 
                ListTile(
                  leading: Image.network(photoMemos[index].photoURL),
                  title: Text(photoMemos[index].title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Created by: ${photoMemos[index].createdBy}"),
                      Text("Updated at: ${photoMemos[index].updatedAt}"),
                      Text(photoMemos[index].memo),
                    ]
                  ),
                ),
              ),
      ),
    );
  }
}

class _Controller {
  _HomeScreenState _state;
  _Controller(this._state);

  void signOut() async {
    try {
      await FirebaseController.signOut();
    } catch (e) {
      print("signOut exception: ${e.message}");
    }
    Navigator.pushReplacementNamed(_state.context, SignInScreen.routeName);
  }

  void addButton() async {
    //navigate to add screen to add images
    await Navigator.pushNamed(_state.context, AddScreen.routeName,
    arguments: {'user': _state.user, 'photoMemoList': _state.photoMemos});
    _state.render((){});
  }
}
