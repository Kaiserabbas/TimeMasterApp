import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './theme_provider.dart';

class CreditsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, color: theme.textColor, size: 48),
              SizedBox(height: 24),
              Text(
                "Author: Hashim Mirqal & Meeram Zahra",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: theme.textColor,
                  fontFamily: theme.fontFamily,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "All rights reserved © 2025\nMeeram & Mirqal Studio",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.textColor,
                  fontFamily: theme.fontFamily,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
