import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
  double? salario;
  double? totalEntries;
  double? sumEntries;
  double? totalExpenses;
  double? netBalance;
  Map<String, double> expensesByCategory = {};

  @override
  void initState() {
    super.initState();
    carregarNomeAsync();
    carregarSalario(); 
    _loadTotalEntries();
    _loadExpensesByCategory(); // Carrega despesas separadas por categoria
  }

  Future<void> carregarSalario() async {
    final prefs = await SharedPreferences.getInstance();
    double? salary = prefs.getDouble('salary');
    setState(() {
      salario = salary ?? 0;
    });
    _calculateSum(); // Recalcula a soma sempre que o salário é carregado
  }

  Future<void> carregarNomeAsync() async {
    final prefs = await SharedPreferences.getInstance();
    String? nomeSalvo = prefs.getString('userName');
    setState(() {
      userName = nomeSalvo ?? widget.userName; // Se o nome salvo for nulo, use o nome passado como argumento
    });
  }

  Future<void> _loadTotalEntries() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalEntries = prefs.getDouble('totalEntries') ?? 0.0;
    });
    _calculateSum(); // Recalcula a soma sempre que as entradas são carregadas
  }

  Future<void> _loadExpensesByCategory() async {
    final prefs = await SharedPreferences.getInstance();
    final expenses = prefs.getString('expenses') ?? '{}';
    final expenseMap = jsonDecode(expenses) as Map<String, dynamic>;

    double sumExpenses = 0.0;
    Map<String, double> categoryExpenses = {};

    expenseMap.forEach((category, value) {
      final expenseValue = double.tryParse(value.toString()) ?? 0.0;
      categoryExpenses[category] = expenseValue;
      sumExpenses += expenseValue;
    });

    setState(() {
      totalExpenses = sumExpenses;
      expensesByCategory = categoryExpenses; // Armazena despesas separadas por categoria
    });

    _calculateNetBalance(); // Atualiza o saldo final ao carregar as despesas
  }

  // Função que calcula a soma das entradas e o salário
  void _calculateSum() {
    setState(() {
      sumEntries = (salario ?? 0) + (totalEntries ?? 0);
    });
    _calculateNetBalance(); // Recalcula o saldo final quando as entradas são atualizadas
  }

  // Função que calcula o saldo final subtraindo as despesas das entradas
  void _calculateNetBalance() {
    setState(() {
      netBalance = (sumEntries ?? 0) - (totalExpenses ?? 0);
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
                        padding: const EdgeInsets.all(15),
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.arrow_downward,
                          size: 35.0,
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
                        padding: const EdgeInsets.all(15),
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.arrow_upward,
                          size: 35.0,
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
                        padding: const EdgeInsets.all(15),
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.settings,
                          size: 35.0,
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
              ],
            ),
            // Resumo de gestão de dinheiro
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'Resumo de entradas',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF72C96A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildMoneySummary('Salário', 'R\$ $salario', ''),
                  const SizedBox(height: 10),
                  _buildMoneySummary('Renda extra', 'R\$ $totalEntries', ''),
                  const SizedBox(height: 10),
                  _buildMoneySummary('Total de entradas', 'R\$ $sumEntries', ''),
                  const SizedBox(height: 10),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                  ),
                  Text(
                    'Resumo de Despesas',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFE65F5F),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Exibe as despesas por categoria
                  ...expensesByCategory.entries.map((entry) {
                    return _buildMoneySummary(
                      entry.key, // Categoria
                      'R\$ ${entry.value.toStringAsFixed(2)}', // Valor
                      '',
                    );
                  }).toList(),
                  const SizedBox(height: 10),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                  ),
                  const SizedBox(height: 10),
                  _buildMoneySummary('Saldo final', 'R\$ $netBalance', ''),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Método para exibir o resumo das finanças
  Widget _buildMoneySummary(String title, String value, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4180AB),
              ),
            ),
            if (subtitle.isNotEmpty)
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
          ],
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF4180AB),
          ),
        ),
      ],
    );
  }
}

// Exemplo de widget para botões circulares
class CircularButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const CircularButton({Key? key, required this.icon, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF4180AB),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}