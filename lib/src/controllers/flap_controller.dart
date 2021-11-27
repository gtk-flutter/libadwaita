import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class FlapController extends ChangeNotifier {
  bool isOpen = true;
  bool isModal = false;
  // bad practice but can live with it
  BuildContext? context;

  FoldPolicy policy = FoldPolicy.auto;

  bool shouldHide() {
    switch (policy) {
      case FoldPolicy.never:
        return !isOpen;
      case FoldPolicy.always:
        return true;
      case FoldPolicy.auto:
        return isModal || !isOpen;
    }
  }

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
      // This function will be called on every resize. Thus when we resize from
      // a mobile sized window to a desktop sized window and the drawer is open,
      // then the drawer will stay open and the sidebar will also expand. To
      // prevent this, we close the drawer if its already open on a desktop size
      // window.
      if (!isModal) {
        if (Scaffold.of(context).isDrawerOpen && policy != FoldPolicy.always) {
          Navigator.of(context).pop();
        }
      }
      notifyListeners();
    }
  }

  void open({BuildContext? context}) {
    if (!isOpen) {
      isOpen = true;
      // Usually open only should set the isOpen variable, but if we have a
      // mobile sized device OR the fold policy is set to always, we open the
      // drawer because this is how the actual libadwaita behaves
      if (isModal || policy == FoldPolicy.always) {
        Scaffold.of(context ?? this.context!).openDrawer();
      }
      notifyListeners();
    }
  }

  void close({BuildContext? context}) {
    if (isOpen) {
      isOpen = false;
      // Usually close only should set the isOpen variable, but if we have a
      // mobile sized device OR the fold policy is set to always, we close the
      // drawer (if its open) because this is how the actual libadwaita behaves
      if ((isModal || policy == FoldPolicy.always) &&
          Scaffold.of(context ?? this.context!).isDrawerOpen) {
        Navigator.of(context ?? this.context!).pop();
      }
      notifyListeners();
    }
  }

  void toggle({BuildContext? context}) {
    if (isOpen) {
      close(context: context ?? this.context);
    } else {
      open(context: context ?? this.context);
    }
  }
}
