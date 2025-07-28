import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  final List<String> fonts = ['Roboto', 'Monospace', 'Open Sans', 'Lato'];
  final List<Color> colors = [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.cyan,
    Colors.orange,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: Text("Background Color"),
            subtitle: Wrap(
              spacing: 8,
              children: colors.map((color) {
                return GestureDetector(
                  onTap: () => theme.setBackgroundColor(color),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.backgroundColor == color
                            ? Colors.white
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Divider(),
          ListTile(
            title: Text("Text Color"),
            subtitle: Wrap(
              spacing: 8,
              children: colors.map((color) {
                return GestureDetector(
                  onTap: () => theme.setTextColor(color),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.textColor == color
                            ? Colors.white
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Divider(),
          ListTile(
            title: Text("Font Style"),
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
            title: Text("Font Size (${theme.fontSize.toInt()})"),
            subtitle: Slider(
              value: theme.fontSize,
              min: 20,
              max: 100,
              divisions: 16,
              label: theme.fontSize.toInt().toString(),
              onChanged: (val) => theme.setFontSize(val),
            ),
          ),
        ],
      ),
    );
  }
}
