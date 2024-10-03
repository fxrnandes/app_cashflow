import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/shared_services.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  String? _userName;
  double? _salario;
  double? _totalEntries;
  double? _sumEntries;
  double? _netBalance;
  Map<String, double> _expensesByCategory = {};
  Future<void>? _future;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Olá, ${_userName ?? 'Usuário'}!',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4180AB),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
            _buildMoneySummary('Salário', 'R\$ $_salario', ''),
            const SizedBox(height: 10),
            _buildMoneySummary('Renda extra', 'R\$ $_totalEntries', ''),
            const SizedBox(height: 10),
            _buildMoneySummary('Total de entradas', 'R\$ $_sumEntries', ''),
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
            ..._expensesByCategory.entries.map((entry) {
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
            _buildMoneySummary('Saldo final', 'R\$ $_netBalance', ''),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
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
    Future<void> _initData() async {
    await carregarNomeAsync();
    await carregarSalario();
    await loadTotalEntries();
    await loadExpensesByCategory();
    setState(() {
      _userName = userName;
      _salario = salario;
      _totalEntries = totalEntries;
      _sumEntries = sumEntries;
      _netBalance = netBalance;
      _expensesByCategory = expensesByCategory;
    });
    return;
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


