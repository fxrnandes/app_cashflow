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

  Future<void> _saveAndNavigate() async {
    // Salvando o nome no SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);

    // Navegando para a próxima tela, após garantir que o widget está montado
    if (mounted) {
      Navigator.pushNamed(context, '/name');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),

                // Subtítulo centralizado mais abaixo
                Text(
                  'Informe o seu nome',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4180AB),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Linha de input centralizada com largura ajustada
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
                const Spacer(),

                // Botão reposicionado mais embaixo
                SizedBox(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _saveAndNavigate, // Chamada da função que lida com navegação
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

          // Círculo no canto superior direito
          const Positioned(
            top: 40,
            right: 16,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xFF4180AB),
              child: Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
