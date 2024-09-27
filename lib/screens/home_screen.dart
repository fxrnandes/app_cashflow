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

  @override
  void initState() {
    super.initState();
    carregarNomeAsync();
    carregarSalario(); // Carrega o nome salvo assim que a tela é iniciada
    _loadTotalEntries();
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

  // Função que calcula a soma das entradas e o salário
  void _calculateSum() {
    setState(() {
      sumEntries = (salario ?? 0) + (totalEntries ?? 0);
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
                  _buildMoneySummary('Salário', 'R\$ $salario', ''),
                  const SizedBox(height: 10),
                  _buildMoneySummary('Entradas', 'R\$ $totalEntries', '+'),
                  const SizedBox(height: 8),
                  _buildMoneySummary('Total', 'R\$ $sumEntries', ''),
                  const SizedBox(height: 10),
                    Text(
                    'Resumo de Despesas',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4180AB),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder(
                    future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final prefs = snapshot.data;
                        final expenses = prefs?.getString('expenses');
                        final expenseMap = expenses != null ? jsonDecode(expenses) : {};

                        if (expenseMap.isEmpty) {
                          return const Center(
                            child: Text('Nenhuma despesa registrada'),
                          );
                        } else {
                          return Column(
                            children: expenseMap.entries.map<Widget>((entry) {
                              return ListTile(
                                title: Text(entry.key),
                                trailing: Text('R\$ ${entry.value}'),
                              );
                            }).toList(),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: RawMaterialButton(
          elevation: 2.0,
          fillColor: const Color(0xFFE4EBF0),
          padding: const EdgeInsets.all(12.5),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.clear,
            size: 30.0,
            color: Color(0xFF4180AB),
          ),
          onPressed: () {
            limparSharedPreferences();
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
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
