import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/counter_model.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Multi Counter')),
      body: ListView.builder(
        itemCount: counterProvider.counters.length,
        itemBuilder: (context, index) {
          final counter = counterProvider.counters[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: TextField(
                controller: TextEditingController(text: counter.name),
                decoration: InputDecoration(border: InputBorder.none),
                onSubmitted: (val) => counterProvider.updateName(index, val),
              ),
              subtitle: Text(
                'Value: ${counter.value}',
                style: TextStyle(fontSize: 20),
              ),
              trailing: Wrap(
                spacing: 8,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => counterProvider.decrement(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => counterProvider.increment(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () => counterProvider.reset(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => counterProvider.removeCounter(index),
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
}
