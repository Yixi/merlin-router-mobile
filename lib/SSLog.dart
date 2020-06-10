import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SSLog extends StatefulWidget {
  @override
   createState() => _SSLogState();
}

class _SSLogState extends State<SSLog> with SingleTickerProviderStateMixin{

  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text("123");
          ],
        ),
      ),
    );
  }

}