import 'package:flutter/material.dart';

class FlowProvider with ChangeNotifier {
  bool _isHomePageNeedRefresh = false;

  bool get homePageNeedRefresh => _isHomePageNeedRefresh;

  void refreshHomePage() {
    _isHomePageNeedRefresh = true;
    notifyListeners();
    _isHomePageNeedRefresh = false;
  }
}
