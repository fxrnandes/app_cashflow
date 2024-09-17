// name_input_screen.dart
import 'package:flutter/material.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  NameInputScreenState createState() => NameInputScreenState(); 
}

class NameInputScreenState extends State<NameInputScreen> { 
  String userName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Digite seu nome")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Seu nome"),
              onChanged: (value) {
                setState(() {
                  userName = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/salary', arguments: userName);
              },
              child: const Text('Próximo'),
            ),
          ],
        ),
      ),
    );
  }
}
