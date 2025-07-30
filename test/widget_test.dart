import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:time_master_app/main.dart'; // ✅ use your correct app name
import 'package:time_master_app/screens/theme_provider.dart'; // ✅ fix path if needed

void main() {
  testWidgets('time_master_app loads with bottom navigation',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: time_master_app(),
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
}
