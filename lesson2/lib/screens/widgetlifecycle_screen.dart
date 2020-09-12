import 'package:flutter/material.dart';

class WidgetLifeCycle extends StatefulWidget{
  static const routeName = '/widgetLifecycle';
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WidgetLifeCyclestate();
  }

}

class _WidgetLifeCyclestate extends State<WidgetLifeCycle>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Widget Life Cycle"),
      ),
      body: Text("Test"),
    );
  }

}