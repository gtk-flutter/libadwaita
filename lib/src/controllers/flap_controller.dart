import 'package:flutter/material.dart';
import 'package:libadwaita/src/widgets/adw/flap.dart';

class FlapController extends ChangeNotifier {
  FlapController([this.key]);

  final Key? key;

  bool isOpen = true;
  bool isModal = false;

  // bad practice but can live with it
  /// INTERNAL STUFF, DON'T USE DIRECTLY
  BuildContext? context;

  FoldPolicy _policy = FoldPolicy.auto;
  FlapPosition _position = FlapPosition.start;
  bool _locked = false;

  set policy(FoldPolicy policy) => _policy = policy;
  set position(FlapPosition position) => _position = position;
  set locked(bool locked) => _locked = locked;

  bool shouldEnableDrawerGesture(FlapPosition position) {
    return isModal && _position == position;
  }

  bool shouldHide() {
    switch (_policy) {
      case FoldPolicy.never:
        return !isOpen;
      case FoldPolicy.always:
        return true;
      case FoldPolicy.auto:
        return isModal || !isOpen;
    }
  }

  // ignore: avoid_positional_boolean_parameters
  void onDrawerChanged(bool state) => updateOpenState(state: state);

  void updateOpenState({required bool state}) {
    if (state != isOpen) {
      isOpen = state;
      notifyListeners();
    }
  }

  void updateModalState(BuildContext context, {required bool state}) {
    if (state != isModal) {
      isModal = state;
      // This function will be called on every resize. Thus when we resize from
      // a mobile sized window to a desktop sized window and the drawer is open,
      // then the drawer will stay open and the sidebar will also expand. To
      // prevent this, we close the drawer if its already open on a desktop size
      // window.
      if (!isModal) {
        if ((Scaffold.of(context).isDrawerOpen ||
                Scaffold.of(context).isEndDrawerOpen) &&
            _policy != FoldPolicy.always) {
          Navigator.of(context).pop();
        }
      } else if (_locked && isOpen) {
        Scaffold.of(context).openDrawer();
      }
      notifyListeners();
    }
  }

  void open([BuildContext? context]) {
    if (!isOpen) {
      isOpen = true;
      // Usually open only should set the isOpen variable, but if we have a
      // mobile sized device OR the fold policy is set to always, we open the
      // drawer because this is how the actual libadwaita behaves
      if (isModal || _policy == FoldPolicy.always) {
        switch (_position) {
          case FlapPosition.start:
            Scaffold.of(context ?? this.context!).openDrawer();
            break;
          case FlapPosition.end:
            Scaffold.of(context ?? this.context!).openEndDrawer();
            break;
        }
      }
      notifyListeners();
    }
  }

  void close([BuildContext? context]) {
    if (isOpen) {
      isOpen = false;
      final scaffold = Scaffold.of(context ?? this.context!);
      // Usually close only should set the isOpen variable, but if we have a
      // mobile sized device OR the fold policy is set to always, we close the
      // drawer (if its open) because this is how the actual libadwaita behaves
      if ((isModal || _policy == FoldPolicy.always) &&
          (scaffold.isDrawerOpen || scaffold.isEndDrawerOpen)) {
        Navigator.of(context ?? this.context!).pop();
      }
      notifyListeners();
    }
  }

  void toggle({BuildContext? context}) {
    if (isOpen) {
      close(context ?? this.context);
    } else {
      open(context ?? this.context);
    }
  }
}
