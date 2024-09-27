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
                  route: '/selection_entry_screen',
                ),
                _buildCircularOption(
                  icon: Icons.arrow_downward,
                  color: const Color(0xFFE65F5F),
                  text: 'Editar\nSaída',
                  route: '/selection_expense_screen',
                ),
                _buildCircularOption(
                  icon: Icons.edit,
                  color: const Color(0xFF4180AB),
                  text: 'Editar\nInformações',
                  route: '/edit_name_screen',
                ),
              ],
            ),
            const Spacer(),
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
    required String route,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route); // Navega para a tela correta
      },
      child: Column(
        children: [
          RawMaterialButton(
            elevation: 2.0,
            fillColor: const Color(0xFFE4EBF0),
            padding: const EdgeInsets.all(15),
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.pushNamed(context, route); // Navega para a tela correta
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