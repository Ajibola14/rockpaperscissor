import 'package:flutter/material.dart';

class RPS extends ChangeNotifier {
  int _score = 0;
  int get score => _score;
  void updateScore() {
    _score++;
    notifyListeners();
  }
}
