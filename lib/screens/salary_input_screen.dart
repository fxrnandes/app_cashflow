import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalaryInputScreen extends StatefulWidget {
  const SalaryInputScreen({super.key});

  @override
  SalaryInputScreenState createState() => SalaryInputScreenState();
}

class SalaryInputScreenState extends State<SalaryInputScreen> {
  double salary = 0.0;
  String? userName;

  // Carregar o nome salvo
  Future<void> carregarNomeAsync() async {
    final prefs = await SharedPreferences.getInstance();
    String? nomeSalvo = prefs.getString('userName');
    setState(() {
      userName = nomeSalvo ?? 'Usuário';
    });
  }

  // Salvar o salário localmente
  Future<void> salvarSalario() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('salary', salary);  // Salva o salário
  }

  @override
  void initState() {
    super.initState();
    carregarNomeAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'Informe o seu salário',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4180AB),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextFormField(
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF4180AB),
                      width: 2,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF4180AB),
                      width: 2,
                    ),
                  ),
                  labelText: "R\$",
                  labelStyle: TextStyle(
                    color: Color(0xFFBDD1DE),
                    fontSize: 18,
                  ),
                ),
                keyboardType: TextInputType.number,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: Colors.black,
                ),
                onChanged: (value) {
                  setState(() {
                    salary = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  await salvarSalario();
                  Navigator.pushNamed(
                    context,
                    '/home',
                    arguments: userName,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4180AB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Próximo'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
