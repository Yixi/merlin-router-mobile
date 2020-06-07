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
  Map<String, String> pings = Map();

  void getServerPing() {
    dio.get('/ss-ping').then((res) {
      var result = convertSSPing(res.data);
      setState(() {
        this.pings = result;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getServerPing();
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
  final String ping;

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
                ping: ping,
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
    } else if (ping.isEmpty || ping == '0') {
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
