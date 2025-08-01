import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Counter {
  final String id;
  String name;
  int value;
  Color backgroundColor;

  Counter({
    required this.id,
    required this.name,
    required this.value,
    required this.backgroundColor,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'color': backgroundColor.value,
    };
  }

  factory Counter.fromMap(Map<String, dynamic> map) {
    return Counter(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      backgroundColor: Color(map['color']),
    );
  }
}

class CounterProvider extends ChangeNotifier {
  List<Counter> _counters = [];
  final _prefsKey = 'multi_counter_data';

  List<Counter> get counters => _counters;

  CounterProvider() {
    loadCounters();
  }

  void addCounter() {
    final newCounter = Counter(
      id: Uuid().v4(),
      name: 'New Counter',
      value: 0,
      backgroundColor: Colors.teal,
    );
    _counters.add(newCounter);
    saveCounters();
    notifyListeners();
  }

  void removeCounter(String id) {
    _counters.removeWhere((counter) => counter.id == id);
    saveCounters();
    notifyListeners();
  }

  void increment(String id) {
    final counter = _counters.firstWhere((c) => c.id == id);
    counter.value++;
    saveCounters();
    notifyListeners();
  }

  void decrement(String id) {
    final counter = _counters.firstWhere((c) => c.id == id);
    if (counter.value > 0) {
      counter.value--;
      saveCounters();
      notifyListeners();
    }
  }

  void reset(String id) {
    final counter = _counters.firstWhere((c) => c.id == id);
    counter.value = 0;
    saveCounters();
    notifyListeners();
  }

  void updateName(String id, String newName) {
    final counter = _counters.firstWhere((c) => c.id == id);
    counter.name = newName;
    saveCounters();
    notifyListeners();
  }

  void updateColor(String id, Color newColor) {
    final counter = _counters.firstWhere((c) => c.id == id);
    counter.backgroundColor = newColor;
    saveCounters();
    notifyListeners();
  }

  Counter? getCounterById(String id) {
    try {
      return _counters.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveCounters() async {
    final prefs = await SharedPreferences.getInstance();
    final counterList = _counters.map((c) => json.encode(c.toMap())).toList();
    await prefs.setStringList(_prefsKey, counterList);
  }

  Future<void> loadCounters() async {
    final prefs = await SharedPreferences.getInstance();
    final storedList = prefs.getStringList(_prefsKey) ?? [];
    _counters = storedList
        .map((jsonStr) => Counter.fromMap(json.decode(jsonStr)))
        .toList();
    notifyListeners();
  }
}
