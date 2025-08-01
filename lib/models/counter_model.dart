import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Counter {
  String name;
  int value;

  Counter({required this.name, this.value = 0});

  Map<String, dynamic> toMap() => {'name': name, 'value': value};

  factory Counter.fromMap(Map<String, dynamic> map) =>
      Counter(name: map['name'], value: map['value']);
}

class CounterProvider extends ChangeNotifier {
  List<Counter> _counters = [];

  List<Counter> get counters => _counters;

  Future<void> loadCounters() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('counters');
    if (data != null) {
      List<dynamic> decoded = json.decode(data);
      _counters = decoded.map((e) => Counter.fromMap(e)).toList();
    }
    notifyListeners();
  }

  Future<void> saveCounters() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(_counters.map((e) => e.toMap()).toList());
    await prefs.setString('counters', encoded);
  }

  void addCounter() {
    _counters.add(Counter(name: 'New Counter'));
    saveCounters();
    notifyListeners();
  }

  void removeCounter(int index) {
    _counters.removeAt(index);
    saveCounters();
    notifyListeners();
  }

  void increment(int index) {
    _counters[index].value++;
    saveCounters();
    notifyListeners();
  }

  void decrement(int index) {
    if (_counters[index].value > 0) {
      _counters[index].value--;
      saveCounters();
      notifyListeners();
    }
  }

  void reset(int index) {
    _counters[index].value = 0;
    saveCounters();
    notifyListeners();
  }

  void updateName(int index, String newName) {
    _counters[index].name = newName;
    saveCounters();
    notifyListeners();
  }
}
