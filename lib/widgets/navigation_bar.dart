import 'package:flutter/material.dart';

class NavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NavigationBarWidget({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
