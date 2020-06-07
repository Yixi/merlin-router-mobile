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
    return MaterialApp(home: Scaffold(body: Home()));
  }
}

Future<SSConfig> getSSConfig() =>
    dio.get("/ss-config").then((res) => convertSSConfig(res.data));

class Home extends StatefulWidget {
  @override
  createState() => new _HomeState();
}

class _HomeState extends State<Home> {
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
            return Dashboard(
              config: config,
            );
          }
        } else {
          return Center(child: Text("Loading..."));
        }
      },
    );
  }
}

class Dashboard extends StatefulWidget {
  Dashboard({this.config});

  final SSConfig config;

  @override
  createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  SSConfig configState;
  num key = 0;

  Future<void> onRefresh() {
    return getSSConfig().then((data) {
      setState(() {
        this.configState = data;
        key++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var config = configState ?? widget.config;
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
            onRefresh: onRefresh,
            key: Key(key.toString()),
          ),
        ],
      ),
    );
  }
}
