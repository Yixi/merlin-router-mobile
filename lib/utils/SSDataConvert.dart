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
  var nameKeys = configRes.keys.where((String k) {
    return k.startsWith("ssconf_basic_name_");
  });
  Iterable.generate(nameKeys.length, (i) => i + 1).forEach((key) {
    nodes.add(SSConfigNode(
      key: key.toString(),
      name: configRes['ssconf_basic_name_$key'],
      server: configRes['ssconf_basic_server_$key'],
      type: "0",
      isSelected: configRes['ssconf_basic_node'] == key.toString()
    ));
  });
  return nodes;
}
