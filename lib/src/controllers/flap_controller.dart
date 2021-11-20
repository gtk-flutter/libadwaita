import 'package:flutter/foundation.dart';

class FlapController extends ChangeNotifier {
  bool isOpen = false;

  void update(bool val) {
    if (val != isOpen) {
      isOpen = val;
      notifyListeners();
    }
  }

  void open() {
    if (!isOpen) {
      isOpen = true;
      notifyListeners();
    }
  }

  void close() {
    if (isOpen) {
      isOpen = false;
      notifyListeners();
    }
  }

  void toggle() {
    isOpen = !isOpen;
    notifyListeners();
  }
}
