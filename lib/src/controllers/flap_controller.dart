import 'package:flutter/material.dart';

class FlapController extends ChangeNotifier {
  bool isOpen = false;
  bool isModal = false;

  void onDrawerChanged(bool val) {
    updateOpenState(val);
  }

  void updateOpenState(bool val) {
    if (val != isOpen) {
      isOpen = val;
      notifyListeners();
    }
  }

  void updateModalState(BuildContext context, bool val) {
    if (val != isModal) {
      isModal = val;
      if (!isModal) {
        if (Scaffold.of(context).isDrawerOpen) {
          Navigator.of(context).pop();
        }
      }
      notifyListeners();
    }
  }

  void open(BuildContext context) {
    if (!isOpen) {
      isOpen = true;
      if (isModal) {
        Scaffold.of(context).openDrawer();
      }
      notifyListeners();
    }
  }

  void close(BuildContext context) {
    if (isOpen) {
      isOpen = false;
      if (isModal && Scaffold.of(context).isDrawerOpen) {
        Navigator.of(context).pop();
      }
      notifyListeners();
    }
  }

  void toggle(BuildContext context) {
    if (isOpen) {
      close(context);
    } else {
      open(context);
    }
  }
}
