// main.dart
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/name_input_screen.dart';
import 'screens/salary_input_screen.dart';

void main() {
  runApp(const CashflowApp());
}

class CashflowApp extends StatelessWidget {
  const CashflowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cashflow',
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/name': (context) => const NameInputScreen(),
        '/salary': (context) => const SalaryInputScreen(),
      },
    );
  }
}
