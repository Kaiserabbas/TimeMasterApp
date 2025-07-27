import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  Color backgroundColor = Colors.white;
  Color textColor = Colors.black;
  String fontFamily = 'Roboto';

  void updateBackgroundColor(Color color) {
    backgroundColor = color;
    notifyListeners();
  }

  void updateTextColor(Color color) {
    textColor = color;
    notifyListeners();
  }

  void updateFontFamily(String font) {
    fontFamily = font;
    notifyListeners();
  }
}
