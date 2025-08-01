import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:time_master_app/main.dart';
import 'package:time_master_app/screens/theme_provider.dart';
import 'package:time_master_app/screens/counter_screen.dart';
import 'package:time_master_app/models/counter_model.dart';

void main() {
  testWidgets('time_master_app loads with bottom navigation',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: TimeMasterApp(),
      ),
    );

    // Wait for build
    await tester.pumpAndSettle();

    // Test app loads and shows a BottomNavigationBar
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Test the initial screen shows time or something like it
    expect(find.byType(Scaffold), findsWidgets);
  });

  group('Time Master App UI Tests', () {
    testWidgets('Main app loads with BottomNavigationBar and HomeScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => CounterProvider()),
          ],
          child: TimeMasterApp(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Counter screen shows counter and allows increment',
        (WidgetTester tester) async {
      final counterProvider = CounterProvider();
      counterProvider.addCounter();

      await tester.pumpWidget(
        ChangeNotifierProvider<CounterProvider>.value(
          value: counterProvider,
          child: MaterialApp(
            home: CounterScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // One counter card
      expect(find.byType(Card), findsOneWidget);

      // Tap increment button
      final addIcon = find.widgetWithIcon(IconButton, Icons.add);
      expect(addIcon, findsOneWidget);

      await tester.tap(addIcon);
      await tester.pump();

      // Verify the counter increased
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('Counter name is editable', (WidgetTester tester) async {
      final provider = CounterProvider();
      provider.addCounter();

      await tester.pumpWidget(
        ChangeNotifierProvider<CounterProvider>.value(
          value: provider,
          child: MaterialApp(
            home: CounterScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      await tester.enterText(textField, 'Updated Counter');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(provider.counters.first.name, 'Updated Counter');
    });
  });
}
