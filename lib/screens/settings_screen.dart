import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final List<String> fonts = ['Roboto', 'Monospace', 'Open Sans', 'Lato'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ListTile(
              title: Text("Customize Appearance",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text("Pick Background Color (Coming Soon)"),
          ),
          ListTile(
            leading: Icon(Icons.text_fields),
            title: Text("Select Font Style (Coming Soon)"),
          ),
          ListTile(
            leading: Icon(Icons.format_color_text),
            title: Text("Pick Time/Date Color (Coming Soon)"),
          ),
        ],
      ),
    );
  }
}
