import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import './theme_provider.dart';

class ClockScreen extends StatefulWidget {
  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => _currentTime = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    String timeStr =
        "${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}:${_currentTime.second.toString().padLeft(2, '0')}";
    String dateStr =
        "${_currentTime.day}/${_currentTime.month}/${_currentTime.year}";

    return Scaffold(
      body: Container(
        color: theme.backgroundColor,
        width: double.infinity,
        height: double.infinity,
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    timeStr,
                    style: theme.getTextStyle(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    dateStr,
                    style: theme.getTextStyle(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
