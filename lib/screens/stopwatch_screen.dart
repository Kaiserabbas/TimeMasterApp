import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import './theme_provider.dart';

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  List<String> _laps = [];

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    final millis = (d.inMilliseconds.remainder(1000) ~/ 100).toString();
    return "$minutes:$seconds.$millis";
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = _stopwatch.elapsed;
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Stopwatch')),
      body: Container(
        width: double.infinity,
        color: theme.backgroundColor,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              formatDuration(elapsed),
              style: theme.getTextStyle(),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _stopwatch.isRunning ? null : _stopwatch.start,
                  child: Text('Start',
                      style: TextStyle(fontFamily: theme.fontFamily)),
                ),
                ElevatedButton(
                  onPressed: _stopwatch.isRunning ? _stopwatch.stop : null,
                  child: Text('Stop',
                      style: TextStyle(fontFamily: theme.fontFamily)),
                ),
                ElevatedButton(
                  onPressed: () {
                    _stopwatch.reset();
                    _laps.clear();
                    setState(() {});
                  },
                  child: Text('Reset',
                      style: TextStyle(fontFamily: theme.fontFamily)),
                ),
                ElevatedButton(
                  onPressed: _stopwatch.isRunning
                      ? () {
                          _laps.insert(0, formatDuration(_stopwatch.elapsed));
                          setState(() {});
                        }
                      : null,
                  child: Text('Lap',
                      style: TextStyle(fontFamily: theme.fontFamily)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _laps.isEmpty
                  ? Center(
                      child: Text("No laps yet",
                          style: TextStyle(
                              color: theme.textColor,
                              fontFamily: theme.fontFamily)))
                  : ListView.builder(
                      itemCount: _laps.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            "Lap ${_laps.length - index}",
                            style: TextStyle(
                                color: theme.textColor,
                                fontFamily: theme.fontFamily),
                          ),
                          trailing: Text(
                            _laps[index],
                            style: TextStyle(
                                color: theme.textColor,
                                fontFamily: theme.fontFamily),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
