import 'dart:convert';

import 'package:flutter/material.dart';

class SSConfigCurrent {
  SSConfigCurrent({
    this.enable,
    this.currentKey,
    this.name,
    this.mode,
  });

  bool enable;
  String currentKey;
  String name;
  String mode;
}

class SSConfigNode {
  SSConfigNode({this.key, this.isSelected, this.type, this.name, this.server});

  String key;
  bool isSelected;
  String type;
  String name;
  String server;
}

class SSConfig {
  SSConfig({this.current, this.nodes});

  SSConfigCurrent current;
  List<SSConfigNode> nodes;
}

Map<String, String> typeDes = {
  "0": "ss",
  "1": "ssr",
  "2": "Koolgame",
  "3": "v2ray"
};

SSConfig convertSSConfig(dynamic data) {
  Map<String, dynamic> result = data['result'][0];

  var current = generateCurrentInfo(result);

  return SSConfig(current: current, nodes: generateNodes(result));
}

SSConfigCurrent generateCurrentInfo(Map<String, dynamic> configRes) {
  var currentKey = configRes['ssconf_basic_node'];
  return SSConfigCurrent(
    enable: configRes['ss_basic_enable'] == "1",
    currentKey: currentKey,
    name: configRes['ssconf_basic_name_$currentKey'],
    mode: configRes['ssconf_basic_mode_$currentKey'],
  );
}

List<SSConfigNode> generateNodes(Map<String, dynamic> configRes) {
  List<SSConfigNode> nodes = [];
  var configResKeys = configRes.keys;
  String getType({String key}) {
    if (configResKeys.contains('ssconf_basic_rss_protocol_$key')) {
      return "1";
    }
    if (configResKeys.contains('ssconf_basic_koolgame_udp_$key')) {
      return "2";
    }
    if (configResKeys.contains('ssconf_basic_v2ray_use_json_$key')) {
      return "3";
    }
    return "0";
  }

  var nameKeys = configResKeys.where((String k) {
    return k.startsWith("ssconf_basic_name_");
  });
  Iterable.generate(nameKeys.length, (i) => i + 1).forEach((key) {
    nodes.add(SSConfigNode(
        key: key.toString(),
        name: configRes['ssconf_basic_name_$key'],
        server: configRes['ssconf_basic_server_$key'],
        type: getType(key: key.toString()),
        isSelected: configRes['ssconf_basic_node'] == key.toString()));
  });
  return nodes;
}

Map<String, List<String>> convertSSPing(dynamic resData) {
  String result = resData['result'];
  Map<String, List<String>> pings = Map();
  List<dynamic> pingArray =
      jsonDecode(String.fromCharCodes(base64Decode(result)));
  pingArray.forEach((element) {
    if (element != null) {
      pings[element[0]] = [element[1], element[2]];
    }
  });
  return pings;
}

List<List<String>> convertSSStatus(dynamic resData) {
  String result = resData['result'];
  var status = result.split('@@');
  print(status);
  var foreignTimeMatch = RegExp("【(.*?)】").firstMatch(status[0]);
  var foreignPingMatch = RegExp(r"(\d+)\sms").firstMatch(status[0]);
  var inlandTimeMatch = RegExp("【(.*?)】").firstMatch(status[1]);
  var inlandPingMatch = RegExp(r"(\d+)\sms").firstMatch(status[1]);

  print(foreignTimeMatch.group(0));
  print(foreignPingMatch.group(1));
  print(inlandTimeMatch.group(0));
  print(inlandPingMatch.group(1));

  return [
    [
      foreignPingMatch != null ? foreignPingMatch[1] : null,
      foreignTimeMatch != null ? foreignTimeMatch.group(0) : null
    ],
    [
      inlandPingMatch != null ? inlandPingMatch[1] : null,
      inlandTimeMatch != null ? inlandTimeMatch.group(0) : null
    ]
  ];
}
