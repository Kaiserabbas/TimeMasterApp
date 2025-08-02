import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './theme_provider.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart'
    if (dart.library.io) 'fake_wakelock.dart';

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

    if (Platform.isAndroid || Platform.isIOS) {
      Wakelock.enable();
    }
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky); // Fullscreen
  }

  @override
  void dispose() {
    _timer.cancel();

    if (Platform.isAndroid || Platform.isIOS) {
      Wakelock.disable();
    }
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // Restore UI

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    final is24Hour = theme.is24HourFormat;

    // Time string
    String timeStr = is24Hour
        ? DateFormat.Hms().format(_currentTime) // 24-hour
        : DateFormat('hh:mm:ss').format(_currentTime); // 12-hour

    // AM/PM for 12-hour mode
    String amPmStr = DateFormat('a').format(_currentTime);

    // Date and weekday
    String dateStr = DateFormat.yMMMMd().format(_currentTime);
    String weekdayStr = DateFormat.EEEE().format(_currentTime);

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
                    textAlign: TextAlign.center,
                  ),
                  if (!is24Hour)
                    Text(
                      amPmStr,
                      style: theme
                          .getTextStyle()
                          .copyWith(fontSize: theme.fontSize * 0.3),
                    ),
                  if (theme.showWeekday)
                    Text(
                      weekdayStr,
                      style: theme
                          .getTextStyle()
                          .copyWith(fontSize: theme.fontSize * 0.2),
                    ),
                  if (theme.showDate)
                    Text(
                      dateStr,
                      style: theme
                          .getTextStyle()
                          .copyWith(fontSize: theme.fontSize * 0.2),
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
