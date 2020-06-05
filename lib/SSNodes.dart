import 'package:flutter/material.dart';
import 'package:merlin/utils/SSDataConvert.dart';

class SSNodes extends StatefulWidget {
  SSNodes({this.nodes});

  final List<SSConfigNode> nodes;

  @override
  createState() => new _SSNodesState();
}

//class _SSNodesState extends State<SSNodes> {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Column(
//        children: widget.nodes.map((node) => Text(node.name)).toList()
//      )
//    );
//  }
//}

class _SSNodesState extends State<SSNodes> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1.2),
        itemCount: widget.nodes.length,
        itemBuilder: (context, index) {
          return SSNode(node: widget.nodes[index]);
        },
      ),
    ));
  }
}

class SSNode extends StatelessWidget {
  SSNode({this.node});

  final SSConfigNode node;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(25, 0, 0, 0),
                offset: Offset(0, 2),
                blurRadius: (6))
          ]),
      child: Text(node.name),
    );
  }
}
