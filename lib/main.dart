import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/theme_provider.dart';
import 'models/counter_model.dart';

import 'screens/clock_screen.dart';
import 'screens/timer_screen.dart';
import 'screens/stopwatch_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/counter_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CounterProvider()),
      ],
      child: TimeMasterApp(),
    ),
  );
}

class TimeMasterApp extends StatefulWidget {
  @override
  _TimeMasterAppState createState() => _TimeMasterAppState();
}

class _TimeMasterAppState extends State<TimeMasterApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ClockScreen(),
    TimerScreen(),
    StopwatchScreen(),
    CounterScreen(), // <- New screen
    SettingsScreen(),
  ];

  final List<String> _titles = [
    'Clock',
    'Timer',
    'Stopwatch',
    'Counters',
    'Settings',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Master',
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          title: Text(_titles[_selectedIndex]),
          backgroundColor: theme.backgroundColor,
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: NavigationBarWidget(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class NavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NavigationBarWidget({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return BottomNavigationBar(
      backgroundColor: theme.backgroundColor,
      selectedItemColor: theme.textColor,
      unselectedItemColor: theme.textColor.withOpacity(0.5),
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Clock'),
        BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Timer'),
        BottomNavigationBarItem(
            icon: Icon(Icons.timer_outlined), label: 'Stopwatch'),
        BottomNavigationBarItem(
            icon: Icon(Icons.countertops), label: 'Counters'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
