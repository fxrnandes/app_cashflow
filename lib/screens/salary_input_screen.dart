import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SalaryInputScreen extends StatefulWidget {
  const SalaryInputScreen({super.key});

  @override
  SalaryInputScreenState createState() => SalaryInputScreenState();
}

class SalaryInputScreenState extends State<SalaryInputScreen> {
  double salary = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(), // Adiciona espaço flexível no topo

            // Título da tela
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

            // Campo para inserir o salário
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

            const Spacer(), // Adiciona espaço flexível antes do botão

            // Botão "Próximo"
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Navegação para a tela principal (a ser implementada)
                  Navigator.pushNamed(context, '/home');
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

            const SizedBox(height: 40), // Espaçamento inferior igual às outras telas
          ],
        ),
      ),
    );
  }
}
