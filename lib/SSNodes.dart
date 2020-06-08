import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merlin/SSStore.dart';
import 'package:merlin/http.dart';
import 'package:merlin/utils/SSDataConvert.dart';
import 'package:provider/provider.dart';

class SSNodes extends StatefulWidget {
  SSNodes({this.nodes, @required this.onRefresh, this.key}) : super(key: key);

  final Key key;
  final List<SSConfigNode> nodes;
  final Future<void> Function() onRefresh;

  @override
  createState() => new _SSNodesState();
}

class _SSNodesState extends State<SSNodes> {
  Map<String, String> pings = Map();

  Future<dynamic> getServerPing() {
    return dio.get('/ss-ping').then((res) {
      var result = convertSSPing(res.data);
      if (this.mounted) {
        setState(() {
          this.pings = result;
        });
      }
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
        child: Stack(
          children: <Widget>[
            Container(
              child: RefreshIndicator(
                onRefresh: widget.onRefresh,
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
            ),
//SSAction()
            Positioned(
              bottom: 0,
                left: 0,
                right: 0,
                child: SSAction()
            )
          ],
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
    return GestureDetector(
      onTap: () {
        context.read<SSStore>().setSelectNode(key: node.key, name: node.name);
      },
      child: Container(
        key: Key(node.key),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
            border: Border.all(
                color: Color(context.watch<SSStore>().currentSelectNodeKey == node.key ? 0xFFf39544 : 0xFF364251),
                width: 2.0
            ),
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

class SSAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var selectNodeKey = context.watch<SSStore>().currentSelectNodeKey;
    var selectNodeName = context.watch<SSStore>().currentSelectNodeName;
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Color(0xFF364251)
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 20),
              alignment: Alignment.centerLeft,
              child: Text("当前选择：$selectNodeName")
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                  color: Color(0xfff02f4d),
                  onPressed: selectNodeKey!=null ?() {
                    print('click');
                  } : null,
                  child: Text("应用"),
                ),
                CupertinoButton(
                  color: Color(0xFF9aa0aa),
                  onPressed:selectNodeKey!=null ? () {
                    context.read<SSStore>().cancelSelect();
                  } : null,
                  child: Text("取消"),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }

}
