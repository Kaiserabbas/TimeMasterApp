import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../lib/models/counter_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Example test', (WidgetTester tester) async {
    // Build your widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: Text('Hello')),
    ));

    // Verify something
    expect(find.text('Hello'), findsOneWidget);
  });
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => counterProvider.addCounter(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: counterProvider.counters.length,
        itemBuilder: (context, index) {
          final counter = counterProvider.counters[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Counter Name Field
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: counter.nameController,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      onSubmitted: (value) {
                        counterProvider.updateName(counter.id, value);
                      },
                    ),
                  ),

                  // Counter Value Display
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        counter.value.toString(),
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  // Icon Buttons
                  Expanded(
                    flex: 3,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          height: constraints.maxWidth * 2 / 3,
                          child: GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () =>
                                    counterProvider.increment(counter.id),
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () =>
                                    counterProvider.decrement(counter.id),
                              ),
                              IconButton(
                                icon: const Icon(Icons.refresh),
                                onPressed: () => _confirmAction(
                                  context,
                                  'Reset',
                                  () => counterProvider.reset(counter.id),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _confirmAction(
                                  context,
                                  'Delete',
                                  () =>
                                      counterProvider.removeCounter(counter.id),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _confirmAction(
      BuildContext context, String action, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$action Counter'),
        content: Text('Are you sure you want to $action this counter?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
