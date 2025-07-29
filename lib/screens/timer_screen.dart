import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import './theme_provider.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Duration _initialDuration = Duration(minutes: 1);
  Duration _remaining = Duration(minutes: 1);
  Timer? _timer;
  bool _isRunning = false;

  void _startTimer() {
    if (_remaining.inSeconds == 0) return;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remaining.inSeconds > 0) {
        setState(() => _remaining -= Duration(seconds: 1));
      } else {
        _stopTimer();
        _showTimeUpDialog();
      }
    });
    setState(() => _isRunning = true);
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _stopTimer();
    setState(() => _remaining = _initialDuration);
  }

  void _pickDuration() async {
    Duration? picked = await showTimePickerDialog(context, _initialDuration);
    if (picked != null) {
      setState(() {
        _initialDuration = picked;
        _remaining = picked;
      });
    }
  }

  Future<Duration?> showTimePickerDialog(
      BuildContext context, Duration initialDuration) async {
    int minutes = initialDuration.inMinutes;
    int seconds = initialDuration.inSeconds % 60;

    Duration? selectedDuration;

    await showDialog(
      context: context,
      builder: (context) {
        int selectedMinutes = minutes;
        int selectedSeconds = seconds;

        return AlertDialog(
          title: Text('Set Timer'),
          content: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Minutes"),
                    NumberPicker(
                      value: selectedMinutes,
                      minValue: 0,
                      maxValue: 59,
                      onChanged: (val) => selectedMinutes = val,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Seconds"),
                    NumberPicker(
                      value: selectedSeconds,
                      minValue: 0,
                      maxValue: 59,
                      onChanged: (val) => selectedSeconds = val,
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                selectedDuration = Duration(
                    minutes: selectedMinutes, seconds: selectedSeconds);
                Navigator.pop(context);
              },
              child: Text('Set'),
            ),
          ],
        );
      },
    );

    return selectedDuration;
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Time's Up!"),
        content: Text("Your countdown has finished."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(title: Text('Timer')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formatDuration(_remaining),
            style: theme.getTextStyle(),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _isRunning ? null : _startTimer,
                child: Text('Start', style: theme.getTextStyle()),
              ),
              ElevatedButton(
                onPressed: _isRunning ? _stopTimer : null,
                child: Text(
                  'Pause',
                  style: theme.getTextStyle(),
                ),
              ),
              ElevatedButton(
                onPressed: _resetTimer,
                child: Text(
                  'Reset',
                  style: theme.getTextStyle(),
                ),
              ),
              ElevatedButton(
                onPressed: _isRunning ? null : _pickDuration,
                child: Text(
                  'Set Time',
                  style: theme.getTextStyle(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// NumberPicker fix for null safety
class NumberPicker extends StatelessWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const NumberPicker({
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: value,
      onChanged: (val) {
        if (val != null) onChanged(val);
      },
      items: List.generate(maxValue - minValue + 1, (index) {
        int val = minValue + index;
        return DropdownMenuItem(
          value: val,
          child: Text(val.toString()),
        );
      }),
    );
  }
}
