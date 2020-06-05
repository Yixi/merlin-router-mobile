import 'package:flutter/material.dart';
import 'package:merlin/SSNodes.dart';

import 'SSStatus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Router"),
      ),
      body: Column(children: <Widget>[SSStatus(), SSNodes()]),
    ));
  }
}