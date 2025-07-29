import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider with ChangeNotifier {
  Color _backgroundColor = Colors.black;
  Color _textColor = Colors.white;
  String _fontFamily = 'Roboto';
  double _fontSize = 60;

  Color get backgroundColor => _backgroundColor;
  Color get textColor => _textColor;
  String get fontFamily => _fontFamily;
  double get fontSize => _fontSize;

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

  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }

  TextStyle getTextStyle() {
    switch (_fontFamily) {
      case 'Lato':
        return GoogleFonts.lato(color: _textColor, fontSize: _fontSize);
      case 'Open Sans':
        return GoogleFonts.openSans(color: _textColor, fontSize: _fontSize);
      case 'Orbitron':
        return GoogleFonts.orbitron(color: _textColor, fontSize: _fontSize);
      case 'Anton':
        return GoogleFonts.anton(color: _textColor, fontSize: _fontSize);
      case 'Bebas Neue':
        return GoogleFonts.bebasNeue(color: _textColor, fontSize: _fontSize);
      default:
        return GoogleFonts.roboto(color: _textColor, fontSize: _fontSize);
    }
  }
}
