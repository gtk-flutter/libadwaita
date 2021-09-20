import 'package:flutter/material.dart';
import 'package:gtk/gtk.dart';

class GnomeThemeProvider with ChangeNotifier {
  GnomeTheme theme = GnomeTheme();

  GnomeThemeProvider() {
    load();
  }

  Future<void> load() async {
    await theme.loadFromFile();
    theme.parse();
    notifyListeners();
  }

  ThemeData getTheme() => theme.themeData;
}
