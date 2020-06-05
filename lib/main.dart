import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:merlin/SSNodes.dart';
import 'package:merlin/utils/SSDataConvert.dart';

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
            body: Dashboard()));
  }
}

class Dashboard extends StatefulWidget {
  @override
  createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Dio _dio = new Dio();

  Future getSSConfig() => _dio.get("http://192.168.50.1/_api/ss").then((res) => convertSSConfig(res.data));

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
            return Column(
              children: <Widget>[
                SSStatus(),
                SSNodes(),
              ],
            );
          }
        } else {
          return Center(child: Text("Loading..."));
        }
      },
    );
  }
}
