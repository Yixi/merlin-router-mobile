class SSConfigCurrent {
  SSConfigCurrent({bool enable, String currentKey, String name, String mode}) {
    this.enable = enable;
    this.currentKey = currentKey;
    this.name = name;
    this.mode = mode;
  }

  bool enable;
  String currentKey;
  String name;
  String mode;
}

class SSConfigNode {
  SSConfigNode(
      {String key, bool isSelected, String type, String name, String server}) {
    this.key = key;
    this.isSelected = isSelected;
    this.type = type;
    this.name = name;
    this.server = server;
  }

  String key;
  bool isSelected;
  String type;
  String name;
  String server;
}

class SSConfig {
  SSConfig({SSConfigCurrent current, List<SSConfigNode> nodes}) {
    this.current = current;
    this.nodes = nodes;
  }

  SSConfigCurrent current;
  List<SSConfigNode> nodes;
}

dynamic convertSSConfig(dynamic data) {
  Map<String, dynamic> result = data['result'][0];
  print(result);
  print(result.keys);
//  Map<String, dynamic> config = jsonDecode(result.toString());
//  print(config);
  result.keys.forEach((element) {
    print(element);
  });
}
