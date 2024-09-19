import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centralizando horizontalmente
          children: [
            // Espaço para jogar o conteúdo mais abaixo
            const Spacer(),

            // Subtítulo centralizado mais abaixo
            Text(
              'Informe o seu nome',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4180AB), // Cor do subtítulo
              ),
              textAlign: TextAlign.center, // Centralizando o texto
            ),

            const SizedBox(height: 20),

            // Linha de input centralizada com largura ajustada
            SizedBox(
              width: 300, // Definindo a largura da linha de input
              child: TextFormField(
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF4180AB), // Cor da linha
                      width: 2,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF4180AB), // Cor da linha ao focar
                      width: 2,
                    ),
                  ),
                ),
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: Colors.black,
                ),
                onChanged: (value) {
                  setState(() {
                    userName = value;
                  });
                },
              ),
            ),

            // Espaço para empurrar o conteúdo superior e inferior
            const Spacer(),

            // Botão reposicionado mais embaixo
            SizedBox(
              width: 300, // Largura do botão
              height: 60,  // Altura do botão
              child: ElevatedButton(
                onPressed: () async {
                  // Verificar se o widget ainda está montado antes de executar operações assíncronas
                  if (mounted) {
                    await _saveAndNavigate();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4180AB), // Cor de fundo
                  foregroundColor: Colors.white, // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bordas arredondadas
                  ),
                  textStyle: GoogleFonts.inter(
                    fontSize: 20, // Tamanho do texto
                    fontWeight: FontWeight.w600, // Semi-bold
                  ),
                ),
                child: const Text('Próximo'),
              ),
            ),

            const SizedBox(height: 40), // Espaço extra abaixo do botão
          ],
        ),
      ),
    );
  }

  Future<void> _saveAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);

    // Após salvar o nome, navegue para a próxima tela, se o widget ainda estiver montado
    if (mounted) {
      if (userName.isNotEmpty) {
        Navigator.pushNamed(context, '/salary');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, insira seu nome.')),
        );
      }
    }
  }
}
