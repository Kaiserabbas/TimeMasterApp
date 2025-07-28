import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  Color _backgroundColor = Colors.black;
  Color _textColor = Colors.white;
  String _fontFamily = 'Roboto';

  Color get backgroundColor => _backgroundColor;
  Color get textColor => _textColor;
  String get fontFamily => _fontFamily;

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }

  void setTextColor(Color color) {
    _textColor = color;
    notifyListeners();
  }

  void setFontFamily(String font) {
    _fontFamily = font;
    notifyListeners();
  }

  double _fontSize = 60;

  double get fontSize => _fontSize;

  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }
}
