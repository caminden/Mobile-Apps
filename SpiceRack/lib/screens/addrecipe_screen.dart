import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipe extends StatefulWidget {
  static const routeName = '/recipeBook/addRecipe';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddRecipeState();
  }
}

class _AddRecipeState extends State<AddRecipe> {
  _Controller con;
  var formKey = GlobalKey<FormState>();
  File image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/page.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: image == null
                            ? Icon(
                                Icons.filter_frames,
                                size: 300.0,
                              )
                            : Image.file(image, fit: BoxFit.fill),
                      ),
                      Positioned(
                        right: 0.0,
                        bottom: 0.0,
                        child: Container(
                          color: Colors.blue[100],
                          child: PopupMenuButton<String>(
                            onSelected: con.getPicture,
                            itemBuilder: (context) => <PopupMenuEntry<String>>[
                              PopupMenuItem(
                                value: 'Gallery',
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.photo_album),
                                    Text("Gallery"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 75.0,
                  ),
                  Container(
                    width: 250.0,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Name",
                      ),
                      autocorrect: true,
                      textAlign: TextAlign.center,
                      //validator: ,
                      //onSaved: ,
                    ),
                  ),
                  Container(
                    width: 250,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Prep time",
                      ),
                      autocorrect: true,
                      keyboardType: TextInputType.number,
                      //validator: ,
                      //onSaved: ,
                    ),
                  ),
                  Container(
                    width: 250,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Ingredients",
                      ),
                      autocorrect: true,
                      maxLines: 4,
                      //validator: ,
                      //onSaved: ,
                    ),
                  ),
                  Container(
                    width: 250,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Instructions",
                      ),
                      autocorrect: true,
                      maxLines: 10,
                      //validator: ,
                      //onSaved: ,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _AddRecipeState _state;
  _Controller(this._state);

  void getPicture(String cam) async {
    PickedFile _image;
    ImagePicker picker = ImagePicker();
    try {
      _image = await picker.getImage(source: ImageSource.gallery);
      _state.render(() {
        _state.image = File(_image.path);
      });
    } catch (e) {}
  }
}
