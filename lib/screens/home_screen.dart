import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Função para limpar o SharedPreferences
Future<void> limparSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // Limpa todos os dados do SharedPreferences
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;

  @override
  void initState() {
    super.initState();
    carregarNomeAsync();  // Carrega o nome salvo assim que a tela é iniciada
  }

  Future<void> carregarNomeAsync() async {
    final prefs = await SharedPreferences.getInstance();
    String? nomeSalvo = prefs.getString('userName');
    setState(() {
      userName = nomeSalvo ?? widget.userName;  // Se o nome salvo for nulo, use o nome passado como argumento
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Olá, ${userName ?? 'Usuário'}!',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4180AB),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Botões circulares
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      RawMaterialButton(
                        elevation: 2.0,
                        fillColor: const Color(0xFFE4EBF0),
                        padding: const EdgeInsets.all(12.5),
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.arrow_downward,
                          size: 30.0,
                          color: Color(0xFFE65F5F),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/expense');
                        },
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Cadastrar\nsaída',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4180AB),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      RawMaterialButton(
                        elevation: 2.0,
                        fillColor: const Color(0xFFE4EBF0),
                        padding: const EdgeInsets.all(12.5),
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.arrow_upward,
                          size: 30.0,
                          color: Color(0xFF72C96A),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/entry');
                        },
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Cadastrar\nentrada',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4180AB),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      RawMaterialButton(
                        elevation: 2.0,
                        fillColor: const Color(0xFFE4EBF0),
                        padding: const EdgeInsets.all(12.5),
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.settings,
                          size: 30.0,
                          color: Color(0xFF4180AB),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit');
                        },
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Editar\ninformações',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4180AB),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      RawMaterialButton(
                        elevation: 2.0,
                        fillColor: const Color(0xFFE4EBF0),
                        padding: const EdgeInsets.all(12.5),
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.download,
                          size: 30.0,
                          color: Color(0xFF4180AB),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/downloadSummary');
                        },
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Baixar\nresumo',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4180AB),
                        ),
                      ),
                    ],
                  ),
                ),
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

  // Função para construir o botão circular de limpar
  Widget _buildCircularButtonClear(String label, IconData icon) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            await limparSharedPreferences();
            // Recarregar ou fechar o app para simular uma nova primeira vez
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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
