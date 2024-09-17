// salary_input_screen.dart
import 'package:flutter/material.dart';

class SalaryInputScreen extends StatefulWidget {
  const SalaryInputScreen({super.key});

  @override
  SalaryInputScreenState createState() => SalaryInputScreenState();
}

class SalaryInputScreenState extends State<SalaryInputScreen> {
  double salary = 0.0;

  @override
  Widget build(BuildContext context) {
    final userName = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: const Text("Digite seu salário")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Olá, $userName!', style: const TextStyle(fontSize: 18)),
            TextFormField(
              decoration: const InputDecoration(labelText: "Seu salário"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  salary = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegação para a tela principal (a ser implementada)
                Navigator.pushNamed(context, '/home');
              },
              child: const Text('Próximo'),
            ),
          ],
        ),
      ),
    );
  }
}
