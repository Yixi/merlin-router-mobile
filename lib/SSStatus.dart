import 'package:flutter/material.dart';
import 'package:merlin/SSNodes.dart';
import 'package:merlin/http.dart';
import 'package:merlin/utils/SSDataConvert.dart';
import 'package:merlin/utils/tools.dart';

class SSStatus extends StatefulWidget {
  SSStatus({this.current});

  final SSConfigCurrent current;

  @override
  createState() => new _SSStatusState();
}

class _SSStatusState extends State<SSStatus> {
  List<List<String>> status = [
    [null, null],
    [null, null]
  ];

  @override
  Widget build(BuildContext context) {

    dio.post("/_api/", data: {
      "id": generateProcessId(),
      "method": "ss_status.sh",
      "params": [],
      "fields": ""
    }).then((res) {
      print(res);
      var result = convertSSStatus(res.data);
      setState(() {
        this.status = result;
      });
    }).catchError((error){
      print(error);
    });

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
                        ping: status[0][0],
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
                        ping: status[1][0],
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
