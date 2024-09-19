import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4180AB), // Cor de fundo
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título
            Text(
              'Cashflow',
              style: GoogleFonts.inter(
                fontSize: 48,
                fontWeight: FontWeight.w900, // Black weight
                color: Colors.white,
              ),
            ),

            // Ajuste no espaçamento
            const SizedBox(height: 0),

            // Subtítulo
            Text(
              'Controle financeiro fácil',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600, // Semi-bold weight
                color: const Color(0xFFBDD1DE),
              ),
            ),

            // Espaçamento
            const SizedBox(height: 40),

            // Logo com ColorFilter
            ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Color(0xFFBDD1DE),
                BlendMode.srcATop,
              ),
              child: Image.asset('assets/images/logo.png', height: 150),
            ),

            // Espaçamento entre a logo e o botão
            const SizedBox(height: 100),

            // Botão modificado
            SizedBox(
              width: 300, // Largura do botão
              height: 60,  // Altura do botão
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/name');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Cor de fundo branca
                  foregroundColor: const Color(0xFF4180AB), // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bordas arredondadas
                  ),
                  textStyle: GoogleFonts.inter(
                    fontSize: 20, // Tamanho do texto
                    fontWeight: FontWeight.w600, // Semi-bold
                  ),
                ),
                child: const Text('Comece Aqui'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
