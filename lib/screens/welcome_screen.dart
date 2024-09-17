import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cashflow")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bem-vindo ao Cashflow', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Image.asset('assets/images/logo.png', height: 150), // Exibindo logo PNG
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/name');
              },
              child: const Text('Comece Aqui'),
            ),
          ],
        ),
      ),
    );
  }
}
