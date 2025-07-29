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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Row 1: Title
              Text(
                "Authors",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.textColor,
                  fontFamily: theme.fontFamily,
                ),
              ),

              // Row 2: Images + Names
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/meeram.jpg'),
                        radius: 50,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Meeram Zahra",
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.textColor,
                          fontFamily: theme.fontFamily,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/mirqal.jpg'),
                        radius: 50,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Hashim Mirqal",
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.textColor,
                          fontFamily: theme.fontFamily,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Row 3: Footer Text
              Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    "All Rights Reserved © 2025",
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.textColor,
                      fontFamily: theme.fontFamily,
                    ),
                  ),
                  Text(
                    "Meeram & Mirqal Studio",
                    style: TextStyle(
                      fontSize: 10,
                      color: theme.textColor,
                      fontFamily: theme.fontFamily,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
