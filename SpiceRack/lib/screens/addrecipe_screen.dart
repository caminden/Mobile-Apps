import 'package:flutter/material.dart';

class AddRecipe extends StatefulWidget{
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
                  SizedBox(height: 75.0,),
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
                        hintText: "Ingredients",
                      ),
                      autocorrect: true,
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

class _Controller{
  _AddRecipeState _state;
  _Controller(this._state);

}