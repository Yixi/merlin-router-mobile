import 'package:flutter/material.dart';
import 'package:merlin/SSNodes.dart';
import 'package:merlin/http.dart';
import 'package:merlin/utils/SSDataConvert.dart';

import 'SSStatus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Dashboard()));
  }
}

class Dashboard extends StatefulWidget {
  @override
  createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Future<SSConfig> getSSConfig() => dio
      .get("/_api/ss")
      .then((res) => convertSSConfig(res.data));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSSConfig(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            var config = snapshot.data;
            return Scaffold(
              backgroundColor: Color(0xFF1f2d3d),
              appBar: PreferredSize(
                preferredSize: Size(100, 120),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Color(0xFF364251),
                  flexibleSpace: SafeArea(
                    child: SSStatus(
                      current: config.current,
                    ),
                  ),
                  brightness: Brightness.dark,
                ),
              ),
              body: Column(
                children: <Widget>[
                  SSNodes(
                    nodes: config.nodes,
                  ),
                ],
              ),
            );
          }
        } else {
          return Center(child: Text("Loading..."));
        }
      },
    );
  }
}
