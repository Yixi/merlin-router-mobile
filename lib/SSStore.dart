import 'package:flutter/cupertino.dart';
import 'package:merlin/utils/SSDataConvert.dart';

class SSStore extends ChangeNotifier {
  String currentSelectNodeKey;
  String currentSelectNodeName;
  String currentSelectMode;
  SSConfig ssConfig;

  void setSelectNode({String key, String name}) {
    currentSelectNodeKey = key;
    currentSelectNodeName = name;
    notifyListeners();
  }

  void cancelSelect() {
    currentSelectNodeKey = null;
    currentSelectNodeName = null;
    notifyListeners();
  }

  void updateSSConfig(SSConfig c){
    ssConfig = c;
  }

}

