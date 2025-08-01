import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './theme_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void _pickColor(BuildContext context, Color currentColor,
    void Function(Color) onColorPicked) {
  showDialog(
    context: context,
    builder: (ctx) {
      Color tempColor = currentColor;
      return AlertDialog(
        title: Text("Pick a Color"),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: (color) => tempColor = color,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          ElevatedButton(
            child: Text("Select"),
            onPressed: () {
              onColorPicked(tempColor);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      );
    },
  );
}

class SettingsScreen extends StatelessWidget {
  final List<String> fonts = [
    'Roboto',
    'Lato',
    'Open Sans',
    'Orbitron',
    'Anton',
    'Bebas Neue',
  ];

  final Map<String, FontVariant> textVariants = {
    'Normal': FontVariant.normal,
    'Bold': FontVariant.bold,
    'Italic': FontVariant.italic,
    'Bold Italic': FontVariant.boldItalic,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          ListTile(
            title: Text("Background Color"),
            trailing: CircleAvatar(backgroundColor: theme.backgroundColor),
            onTap: () => _pickColor(
                context, theme.backgroundColor, theme.setBackgroundColor),
          ),
          Divider(),
          ListTile(
            title: Text("Text Color"),
            trailing: CircleAvatar(backgroundColor: theme.textColor),
            onTap: () =>
                _pickColor(context, theme.textColor, theme.setTextColor),
          ),
          Divider(),
          ListTile(
            title: Text("Font Family"),
            trailing: DropdownButton<String>(
              value: theme.fontFamily,
              onChanged: (val) => theme.setFontFamily(val!),
              items: fonts.map((font) {
                return DropdownMenuItem(
                  value: font,
                  child: Text(font, style: TextStyle(fontFamily: font)),
                );
              }).toList(),
            ),
          ),
          Divider(),
          ListTile(
            title: Text("Text Style"),
            trailing: DropdownButton<FontVariant>(
              value: theme.fontVariant,
              onChanged: (val) => theme.setFontVariant(val!),
              items: textVariants.entries.map((entry) {
                return DropdownMenuItem(
                  value: entry.value,
                  child: Text(entry.key),
                );
              }).toList(),
            ),
          ),
          Divider(),
          ListTile(
            title: Text("Font Size (${theme.fontSize.toInt()})"),
            subtitle: Slider(
              value: theme.fontSize,
              min: 20,
              max: 150,
              divisions: 26,
              label: theme.fontSize.toInt().toString(),
              onChanged: theme.setFontSize,
            ),
          ),
          Divider(),
          SwitchListTile(
            title: Text("24-Hour Format"),
            value: theme.is24HourFormat,
            onChanged: theme.toggleHourFormat,
          ),
          SwitchListTile(
            title: Text("Show Date"),
            value: theme.showDate,
            onChanged: theme.toggleShowDate,
          ),
          SwitchListTile(
            title: Text("Show Weekday"),
            value: theme.showWeekday,
            onChanged: theme.toggleShowWeekday,
          ),
        ],
      ),
    );
  }
}
