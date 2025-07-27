import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(TimeMasterApp());
}

class TimeMasterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Master',
      theme: ThemeData.dark(),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
