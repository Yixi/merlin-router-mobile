import 'package:flutter/material.dart';

class SSStatus extends StatefulWidget {
  @override
  createState() => new _SSStatusState();
}

class _SSStatusState extends State<SSStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints:
            BoxConstraints(minWidth: double.infinity, minHeight: 100.0),
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(25, 0, 0, 0),
                  offset: Offset(0, 2),
                  blurRadius: (6))
            ]),
        child: Text("当前延迟"));
  }
}
