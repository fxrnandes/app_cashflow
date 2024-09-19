import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Olá, $userName!',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF4180AB),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Botões circulares
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircularButton('Entradas', Icons.arrow_downward),
                _buildCircularButton('Saídas', Icons.arrow_upward),
                _buildCircularButton('Relatório', Icons.pie_chart),
                _buildCircularButton('Configurações', Icons.settings),
              ],
            ),

            const SizedBox(height: 30),

            // Resumo de gestão de dinheiro
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resumo de Gestão de Dinheiro',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4180AB),
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  _buildMoneySummary('Entradas', '+ R\$ 2000', 'Salário'),
                  const SizedBox(height: 10),
                  
                  _buildMoneySummary('Saídas', '- R\$ 500', 'Aluguel'),
                  const SizedBox(height: 10),
                  
                  _buildMoneySummary('Saídas', '- R\$ 200', 'Transporte'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir os botões circulares
  Widget _buildCircularButton(String label, IconData icon) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Navegação para outras telas
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: const Color(0xFF4180AB),
          ),
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Função para construir o resumo de entradas e saídas
  Widget _buildMoneySummary(String category, String amount, String description) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          category,
          style: GoogleFonts.inter(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: amount.contains('-') ? Colors.red : Colors.green,
              ),
            ),
            Text(
              description,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
