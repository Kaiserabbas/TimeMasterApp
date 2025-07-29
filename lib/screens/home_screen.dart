import 'package:flutter/material.dart';
import 'dart:async';
import 'clock_screen.dart';
import 'timer_screen.dart';
import 'stopwatch_screen.dart';
import 'settings_screen.dart';
import 'credits_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _showNav = true;
  Timer? _hideTimer;

  final List<Widget> _screens = [
    ClockScreen(),
    TimerScreen(),
    StopwatchScreen(),
    SettingsScreen(),
    CreditsScreen(), // ✅ New
  ];

  @override
  void initState() {
    super.initState();
    _startHideTimer();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(Duration(seconds: 5), () {
      if (mounted) setState(() => _showNav = false);
    });
  }

  void _onUserInteraction() {
    if (!_showNav) setState(() => _showNav = true);
    _startHideTimer();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onUserInteraction,
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: _showNav
            ? BottomNavigationBar(
                backgroundColor: Colors.grey[900],
                selectedItemColor: Colors.cyanAccent,
                unselectedItemColor: Colors.white70,
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() => _currentIndex = index);
                  _onUserInteraction(); // reset timer
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.access_time), label: 'Clock'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.timer), label: 'Timer'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.av_timer), label: 'Stopwatch'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Settings'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.info_outline), label: 'Credits'),
                ],
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
