import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'http.dart';

void showLog(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return SSLog();
      });
}

class SSLog extends StatefulWidget {
  @override
  createState() => _SSLogState();
}

class _SSLogState extends State<SSLog> with SingleTickerProviderStateMixin {
  String log = '';
  Timer logRequestTimer;

  Future<String> getSSLog() {
    return dio
        .get('/ss-log')
        .then((res) => res.data['log']);
  }

  void requestLogLoop() {
    if (logRequestTimer != null) {
      logRequestTimer.cancel();
    }

    getSSLog().then((l) {
      if (this.mounted) {
        setState(() {
          this.log = l;
        });
      }
    }).whenComplete(
        () => {logRequestTimer = Timer(Duration(seconds: 2), requestLogLoop)});
  }

  @override
  void initState() {
    requestLogLoop();
    super.initState();
  }

  @override
  void dispose() {
    if (logRequestTimer != null) {
      logRequestTimer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var showButton = log.contains('XU6J03M6');
    return Container(
      height: 700,
      decoration: BoxDecoration(color: Color(0xFF364251)),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    reverse: true,
                    controller: ScrollController(initialScrollOffset: 0),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      log,
                      style: TextStyle(fontSize: 10, color: Color(0xFFf0f1f2)),
                    ),
                  ),
                ),
              ),
            ),
            showButton
                ? ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: CupertinoButton(
                        color: Color(0xfff02f4d),
                        child: const Text('关闭'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
