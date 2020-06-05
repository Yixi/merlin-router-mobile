import 'package:flutter/material.dart';
import 'package:merlin/utils/SSDataConvert.dart';

class SSNodes extends StatefulWidget {
  SSNodes({this.nodes});

  final List<SSConfigNode> nodes;

  @override
  createState() => new _SSNodesState();
}

class _SSNodesState extends State<SSNodes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: widget.nodes.map((node) => Text(node.name)).toList()
      )
    );
  }
}
