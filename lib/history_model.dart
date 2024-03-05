// history_model.dart
import 'package:flutter/material.dart';

class HistoryModel extends ChangeNotifier {
  List<String> _historyList = [];

  List<String> get historyList => _historyList;

  void addToHistory(String calculation) {
    _historyList.add(calculation);
    notifyListeners();
  }
}
