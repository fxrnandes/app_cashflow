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

  // Função para salvar o nome no SharedPreferences
  Future<void> _saveName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // Adicionado SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  color: const Color(0xFF4180AB),
                  onPressed: () {
                    Navigator.pop(context); // Fecha a tela ao clicar no "X"
                  },
                ),
              ),
              const SizedBox(height: 40),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Informe o seu ',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4180AB),
                  ),
                  children: [
                    TextSpan(
                      text: 'nome',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFE65F5F),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
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
                  labelText: "Nome",
                  labelStyle: TextStyle(
                    color: Color(0xFFBDD1DE),
                    fontSize: 18,
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
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    await _saveName(); // Chama a função para salvar o nome
                    Navigator.pushNamed(context, '/salary');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE65F5F),
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
      ),
    );
  }
}
