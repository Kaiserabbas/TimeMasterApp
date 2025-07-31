import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum FontVariant { normal, bold, italic, boldItalic }

class ThemeProvider extends ChangeNotifier {
  Color _backgroundColor = Colors.black;
  Color _textColor = Colors.white;
  String _fontFamily = 'Roboto';
  double _fontSize = 64;
  bool _is24HourFormat = true;
  bool _showDate = true;
  bool _showWeekday = false;

  FontVariant _fontVariant = FontVariant.normal;

  // Getters
  Color get backgroundColor => _backgroundColor;
  Color get textColor => _textColor;
  String get fontFamily => _fontFamily;
  double get fontSize => _fontSize;
  bool get is24HourFormat => _is24HourFormat;
  bool get showDate => _showDate;
  bool get showWeekday => _showWeekday;
  FontVariant get fontVariant => _fontVariant;

  FontWeight get fontWeight {
    switch (_fontVariant) {
      case FontVariant.bold:
      case FontVariant.boldItalic:
        return FontWeight.bold;
      default:
        return FontWeight.normal;
    }
  }

  FontStyle get fontStyle {
    switch (_fontVariant) {
      case FontVariant.italic:
      case FontVariant.boldItalic:
        return FontStyle.italic;
      default:
        return FontStyle.normal;
    }
  }

  // Unified TextStyle Generator
  TextStyle getTextStyle() {
    TextStyle baseStyle;

    switch (_fontFamily) {
      case 'Lato':
        baseStyle = GoogleFonts.getFont('Lato');
        break;
      case 'Open Sans':
        baseStyle = GoogleFonts.getFont('Open Sans');
        break;
      case 'Orbitron':
        baseStyle = GoogleFonts.getFont('Orbitron');
        break;
      case 'Anton':
        baseStyle = GoogleFonts.getFont('Anton');
        break;
      case 'Bebas Neue':
        baseStyle = GoogleFonts.getFont('Bebas Neue');
        break;
      default:
        baseStyle = GoogleFonts.getFont('Roboto');
        break;
    }

    return baseStyle.copyWith(
      color: _textColor,
      fontSize: _fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }

  // Setters
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

  void toggleHourFormat(bool value) {
    _is24HourFormat = value;
    notifyListeners();
  }

  void toggleShowDate(bool value) {
    _showDate = value;
    notifyListeners();
  }

  void toggleShowWeekday(bool value) {
    _showWeekday = value;
    notifyListeners();
  }

  void setFontVariant(FontVariant variant) {
    _fontVariant = variant;
    notifyListeners();
  }
}
