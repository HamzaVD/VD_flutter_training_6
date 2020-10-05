import 'package:flutter/cupertino.dart';

class Counter extends ChangeNotifier {
  int value = 0;
  void increment() {
    value += 1;
    notifyListeners();
  }

  void decrement() {
    if (value > 0) {
      value -= 1;
      notifyListeners();
    }
  }
}
