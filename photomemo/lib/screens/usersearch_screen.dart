import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photomemo/controller/firebasecontroller.dart';
import 'package:photomemo/model/photomemo.dart';
import 'package:photomemo/screens/views/myimageview.dart';

class UserSearchScreen extends StatefulWidget {
  static const routeName = '/homeScreen/userSearchScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserSearchState();
  }
}

class _UserSearchState extends State<UserSearchScreen> {
  _Controller con;
  List<PhotoMemo> memos;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    memos ??= ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
        actions: <Widget>[
          Container(
            width: 180.0,
            child: Form(
              key: formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Search specific users",
                  fillColor: Colors.white,
                  filled: true,
                ),
                autocorrect: false,
                onSaved: con.onSavedSearchKey,
                validator: con.onSavedValidator,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: con.search,
          )
        ],
      ),
      body: memos.length == 0
          ? Text(
              "This user hasn't posted photos",
              style: TextStyle(fontSize: 20),
            )
          : ListView.builder(
              itemCount: memos.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    elevation: 5.0,
                    color: Colors.grey[100],
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: MyImageView.network(
                              imageUrl: memos[index].photoURL,
                              context: context),
                          width: MediaQuery.of(context).size.width,
                        ),
                        Text(
                          "${memos[index].title}",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          "${memos[index].memo}",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          "User: ${memos[index].createdBy}",
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _Controller {
  _UserSearchState _state;
  _Controller(this._state);
  String searchKey;

  void search() async {
    if(!_state.formKey.currentState.validate()){
      return;
    }
    
    _state.formKey.currentState.save();

    var result;
    if(searchKey == null || searchKey.trim().isEmpty){
      result = await FirebaseController.getUsers();
    }
    else{
      result = await FirebaseController.getSpecificUsers(searchKey);
    }

    _state.render(() => _state.memos = result);
  }

  void onSavedSearchKey(String s){
    searchKey = s;
  }

  String onSavedValidator(String value){
    if(value == null || value.trim().isEmpty){
      return null;
    }
    else if(!value.contains("@") || !value.contains(".")){
      return "not a valid email search address";
    }
    else{
      return null;
    }
  }
}
