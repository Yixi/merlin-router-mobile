import 'dart:async';
import 'package:flutter/material.dart';
import 'package:merlin/SSNodes.dart';
import 'package:merlin/http.dart';
import 'package:merlin/utils/SSDataConvert.dart';

class SSStatus extends StatefulWidget {
  SSStatus({this.current});

  final SSConfigCurrent current;

  @override
  createState() => new _SSStatusState();
}

class _SSStatusState extends State<SSStatus> {
  List<String> status = [null, null];
  Timer statusRequestTimer;

  void statusLoop() {
    if (statusRequestTimer != null) {
      statusRequestTimer.cancel();
    }
    dio.get("/ss-status").then((res) {
      var result = convertSSStatus(res.data);
      if (this.mounted) {
        setState(() {
          this.status = result;
        });
      }
    }).whenComplete(
        () => {statusRequestTimer = Timer(Duration(seconds: 10), statusLoop)});
  }

  @override
  void initState() {
    super.initState();
    statusLoop();
  }

  @override
  void dispose() {
    super.dispose();
    if (statusRequestTimer != null) {
      statusRequestTimer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: Color(0xFFf0f1f2)),
      child: Container(
          constraints:
              BoxConstraints(minWidth: double.infinity, minHeight: 120.0),
          margin: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text("国外延迟"),
                        padding: EdgeInsets.only(right: 10),
                      ),
                      SSPing(
                        ping: status[0],
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text("国内延迟"),
                        padding: EdgeInsets.only(right: 10),
                      ),
                      SSPing(
                        ping: status[1],
                      )
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("当前节点"),
                  Text('${widget.current.name}')
                ],
              ),
            ],
          )),
    );
  }
}
