import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  EditScreenState createState() => EditScreenState();
}

class EditScreenState extends State<EditScreen> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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

            Text(
              'Área de edição',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4180AB),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8),
            Text(
              'Escolha a opção de edição:',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF8AB3CF),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCircularOption(
                  icon: Icons.arrow_upward,
                  color: const Color(0xFF72C96A),
                  text: 'Editar\nEntrada',
                  value: 'Editar\nEntrada',
                ),
                _buildCircularOption(
                  icon: Icons.arrow_downward,
                  color: const Color(0xFFE65F5F),
                  text: 'Editar\nSaída',
                  value: 'Editar\nSaída',
                ),
                _buildCircularOption(
                  icon: Icons.edit,
                  color: const Color(0xFF4180AB),
                  text: 'Editar\nInformações',
                  value: 'Editar\nInformações',
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para navegar para a tela de edição específica
                  if (selectedOption.isNotEmpty) {
                    Navigator.pushNamed(context, '/${selectedOption.toLowerCase().replaceAll(' ', '_')}');
                  }
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

  // Widget para construir as opções circulares
  Widget _buildCircularOption({
    required IconData icon,
    required Color color,
    required String text,
    required String value,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = value;
        });
      },
      child: Column(
        children: [
          RawMaterialButton(
            elevation: 2.0,
            fillColor: const Color(0xFFE4EBF0),
            padding: const EdgeInsets.all(15),
            shape: const CircleBorder(),
            onPressed: () {
              setState(() {
                selectedOption = value;
              });
            },
            child: Icon(icon, size: 35.0, color: color),
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4180AB),
            ),
          ),
        ],
      ),
    );
  }
}
