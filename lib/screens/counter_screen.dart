// lib/screens/counter_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../models/counter_model.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    return Scaffold(
      body: ListView.builder(
        itemCount: counterProvider.counters.length,
        itemBuilder: (context, index) {
          final counter = counterProvider.counters[index];

          return Card(
            color: counter.backgroundColor,
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // First Column: Counter Name
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: TextEditingController(text: counter.name),
                      onSubmitted: (value) =>
                          counterProvider.updateName(counter.id, value),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Counter Name',
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Second Column: Counter Value
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Text(
                        '${counter.value}',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // Third Column: Icon Buttons in 2 columns, 3 rows
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: Colors.white),
                                onPressed: () =>
                                    counterProvider.decrement(counter.id),
                              ),
                              IconButton(
                                icon: Icon(Icons.refresh, color: Colors.white),
                                onPressed: () => _confirmReset(
                                    context, counter.id, counterProvider),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: () =>
                                    counterProvider.increment(counter.id),
                              ),
                              IconButton(
                                icon:
                                    Icon(Icons.color_lens, color: Colors.white),
                                onPressed: () => _pickColor(
                                  context,
                                  counterProvider,
                                  counter.id,
                                  counter.backgroundColor,
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              IconButton(
                                icon:
                                    Icon(Icons.fullscreen, color: Colors.white),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FullScreenCounterView(
                                        counterId: counter.id),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.white),
                                onPressed: () => _confirmDelete(
                                    context, counter.id, counterProvider),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterProvider.addCounter(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _pickColor(BuildContext context, CounterProvider provider, String id,
      Color currentColor) {
    Color tempColor = currentColor;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Pick Background Color"),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: (color) => tempColor = color,
          ),
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text("Select"),
            onPressed: () {
              provider.updateColor(id, tempColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _confirmReset(
      BuildContext context, String id, CounterProvider provider) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Reset Counter?"),
        content: Text("Are you sure you want to reset this counter to 0?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              provider.reset(id);
              Navigator.pop(context);
            },
            child: Text("Reset"),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(
      BuildContext context, String id, CounterProvider provider) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Delete Counter?"),
        content: Text("Are you sure you want to delete this counter?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              provider.removeCounter(id);
              Navigator.pop(context);
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }
}

class FullScreenCounterView extends StatelessWidget {
  final String counterId;

  const FullScreenCounterView({required this.counterId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CounterProvider>(context);
    final counter = provider.getCounterById(counterId);

    if (counter == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            "Counter not found",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: counter.backgroundColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => provider.increment(counter.id),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                counter.name,
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                '${counter.value}',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.white),
                    iconSize: 40,
                    onPressed: () => provider.decrement(counter.id),
                  ),
                  SizedBox(width: 30),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    iconSize: 40,
                    onPressed: () => provider.increment(counter.id),
                  ),
                ],
              ),
              SizedBox(height: 40),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.fullscreen_exit, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
