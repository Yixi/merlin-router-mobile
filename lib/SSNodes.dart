import 'package:flutter/material.dart';
import 'package:merlin/http.dart';
import 'package:merlin/utils/SSDataConvert.dart';
import 'package:merlin/utils/tools.dart';

class SSNodes extends StatefulWidget {
  SSNodes({this.nodes});

  final List<SSConfigNode> nodes;

  @override
  createState() => new _SSNodesState();
}

class _SSNodesState extends State<SSNodes> {
  Map<String, List<String>> pings;

  @override
  void initState() {
    super.initState();
//    dio.post("/_api/", data: {
//      "id": generateProcessId(),
//      "method": "ss_ping.sh",
//      "params": [],
//      "fields": ""
//    }).then((res) => convertSSPing(res.data));

    var pings = convertSSPing({
      "result":
          "W1siMSIsIjIwNS4yMDciLCIwJSJdLFsiMiIsIjQ2Ni4zMjEiLCIwJSJdLFsiMyIsIiIsIjEwMCUiXSxbIjQiLCIzNy42NTkiLCIwJSJdLFsiNSIsIjQxLjE1OSIsIjAlIl0sWyI2IiwiIiwiMTAwJSJdLFsiNyIsIjQ3Ljc0NyIsIjAlIl0sWyI4IiwiNTIuNTUyIiwiMCUiXSxbIjkiLCI0OS40MzQiLCIwJSJdLFsiMTAiLCI2NC4zMzciLCIwJSJdLFsiMTEiLCI1Ny4yODUiLCIwJSJdLFsiMTIiLCI0Ni4zNTciLCIwJSJdLFsiMTMiLCIiLCIxMDAlIl0sWyIxNCIsIiIsIjEwMCUiXSxbIjE1IiwiMTQ4LjQ2OSIsIjAlIl0sWyIxNiIsIjEzOC4zOTAiLCIwJSJdLFsiMTciLCIyNjEuODEzIiwiMCUiXSxbIjE4IiwiNTAuNTQ4IiwiMCUiXSxbIjE5IiwiMjg3LjU0MSIsIjAlIl0sWyIyMCIsIjExMi41NDIiLCIwJSJdLFsiMjEiLCI1Ni41MTMiLCIwJSJdLFsiMjIiLCI1Ni43NjUiLCIwJSJdLFsiMjMiLCIiLCIxMDAlIl0sWyIyNCIsIjUwLjgzNCIsIjAlIl0sWyIyNSIsIjQ1LjQxMiIsIjAlIl0sWyIyNiIsIjM5LjE2NCIsIjAlIl0sWyIyNyIsIjQ1LjMzMiIsIjAlIl0sWyIyOCIsIjQ3LjA2MiIsIjAlIl0sWyIyOSIsIjU0LjAyOSIsIjAlIl0sWyIzMCIsIiIsIjEwMCUiXSxbIjMxIiwiIiwiMTAwJSJdLFsiMzIiLCIiLCIxMDAlIl0sWyIzMyIsIjI5MC44ODkiLCIwJSJdLFsiMzQiLCI1OS4xNzMiLCIwJSJdLFsiMzUiLCIiLCIxMDAlIl0sWyIzNiIsIjQxMC43NjQiLCIwJSJdLFsiMzciLCIxODguNjg2IiwiMCUiXSxbIjM4IiwiMTg1LjUxNCIsIjAlIl0sWyIzOSIsIjQ2LjE5NCIsIjAlIl0sWyI0MCIsIiIsIjEwMCUiXSxbIjQxIiwiNTEuOTM4IiwiMCUiXSxbIjQyIiwiNDMuMTY4IiwiMCUiXSxbIjQzIiwiNDQuMjYwIiwiMCUiXSxbIjQ0IiwiNjMuNjUyIiwiMCUiXSxbIjQ1IiwiMTYxLjU1NSIsIjAlIl0sWyI0NiIsIjU0LjY0MCIsIjAlIl0sWyI0NyIsIiIsIjEwMCUiXSxbIjQ4IiwiIiwiMTAwJSJdLFsiNDkiLCIiLCIxMDAlIl0sWyI1MCIsIjUwLjg0NyIsIjAlIl0sWyI1MSIsIiIsIjEwMCUiXSxbIjUyIiwiNDkuNDM3IiwiMCUiXSxbIjUzIiwiNTguODQ0IiwiMCUiXSxbIjU0IiwiNDIuODM1IiwiMCUiXSxbIjU1IiwiNDIuNzQ0IiwiMCUiXSxbIjU2IiwiNDUuNTMxIiwiMCUiXSxbIjU3IiwiNTQuMzQ1IiwiMCUiXSxbIjU4IiwiIiwiMTAwJSJdLFsiNTkiLCIiLCIxMDAlIl0sWyI2MCIsIiIsIjEwMCUiXSxbIjYxIiwiMjM3LjgyOSIsIjAlIl0sWyI2MiIsIjY0LjUwNCIsIjAlIl0sWyI2MyIsIjI4NS4xMjEiLCIwJSJdLFsiNjQiLCI1MS4yMjkiLCIwJSJdLFsiNjUiLCIzNy45NDgiLCIwJSJdLFsiNjYiLCI0My43NzAiLCIwJSJdLFsiNjciLCIyOTYuODMyIiwiMCUiXSxbIjY4IiwiNDUuMDQ3IiwiMCUiXSxbIjY5IiwiNDEuNzY2IiwiMCUiXSxbIjcwIiwiNTUuNzI5IiwiMCUiXSxbIjcxIiwiNjMuNTMxIiwiMCUiXSxbIjcyIiwiNTQuNTE5IiwiMCUiXSxbIjczIiwiIiwiMTAwJSJdLFsiNzQiLCIiLCIxMDAlIl0sWyI3NSIsIiIsIjEwMCUiXSxbIjc2IiwiNDkuMjg3IiwiMCUiXSxbIjc3IiwiNTUuNDg1IiwiMCUiXSxbIjc4IiwiNTcuODI2IiwiMCUiXSxbIjc5IiwiNDcuMzIzIiwiMCUiXSxbIjgwIiwiNjcuNjQ3IiwiMCUiXSxbIjgxIiwiNDMuNzMzIiwiMCUiXSxbIjgyIiwiNDQuMzcwIiwiMCUiXSxbIjgzIiwiMTk0LjI4OCIsIjAlIl0sWyI4NCIsIiIsIjEwMCUiXSxbIjg1IiwiIiwiMTAwJSJdLFsiODYiLCIiLCIxMDAlIl0sWyI4NyIsIjU3Ljg1NCIsIjAlIl0sWyI4OCIsIjQyLjIyOSIsIjAlIl0sWyI4OSIsIjU4Ljk5OCIsIjAlIl0sWyI5MCIsIjYxLjEzOCIsIjAlIl0sWyI5MSIsIjM5LjY3NyIsIjAlIl0sWyI5MiIsIjQyLjc0MyIsIjAlIl0sWyI5MyIsIjUzLjc1NCIsIjAlIl0sWyI5NCIsIjc0LjczNCIsIjAlIl0sWyI5NSIsIiIsIjEwMCUiXSxbIjk2IiwiIiwiMTAwJSJdLFsiOTciLCIiLCIxMDAlIl0sWyI5OCIsIjQwLjkzMiIsIjAlIl0sWyI5OSIsIjM5LjQyMCIsIjAlIl0sWyIxMDAiLCI1Mi44MjAiLCIwJSJdLFsiMTAxIiwiMTY3LjM2MCIsIjAlIl0sWyIxMDIiLCIzOS4zNTUiLCIwJSJdLFsiMTAzIiwiNTAuNDY0IiwiMCUiXSxbIjEwNCIsIjQ1LjEzNSIsIjAlIl0sWyIxMDUiLCI2MC4wODAiLCIwJSJdLFsiMTA2IiwiIiwiMTAwJSJdLFsiMTA3IiwiIiwiMTAwJSJdLFsiMTA4IiwiIiwiMTAwJSJdXQo="
    });

    setState(() {
      this.pings = pings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: Color(0xFFf0f1f2)),
      child: Flexible(
        child: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1),
          itemCount: widget.nodes.length,
          itemBuilder: (context, index) {
            return SSNode(
              node: widget.nodes[index],
              ping: pings[widget.nodes[index].key],
            );
          },
        ),
      ),
    );
  }
}

class SSNode extends StatelessWidget {
  SSNode({this.node, this.ping});

  final SSConfigNode node;
  final List<String> ping;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: node.isSelected ? Color(0xFFf02d4d) : Color(0xFF364251),
          borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Text(node.name)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                      color: Color(0xFF9ba1a8),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(typeDes[node.type])),
              SSPing(
                ping: ping[0],
              )
            ],
          )
        ],
      ),
    );
  }
}

class SSPing extends StatelessWidget {
  SSPing({this.ping});

  final String ping;

  Color getColor(p) {
    if (p <= 50) {
      return Color(0xFF1bbf35);
    } else if (p >= 50 && p <= 100) {
      return Color(0xFF3399FF);
    } else if (p > 100) {
      return Color(0xFFF36c21);
    } else {
      return Color(0xFF92526a);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ping == null) {
      return Text(
        "Loading...",
      );
    } else if (ping.isEmpty) {
      return Text(
        "Faild",
        style: TextStyle(color: Colors.red),
      );
    } else {
      var p = double.parse(ping).toInt();
      return Text(
        '$p ms',
        style: TextStyle(color: getColor(p)),
      );
    }
  }
}
