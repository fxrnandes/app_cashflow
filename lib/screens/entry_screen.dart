import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  double totalEntries = 0.0;
  double entry = 0.0;
  String selectedCategory = 'Categoria 1';

  @override
  void initState() {
    super.initState();
    _loadTotalEntries();  // Carregar o valor inicial salvo
  }


  // Carregar o valor de totalEntries do SharedPreferences
  Future<void> _loadTotalEntries() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalEntries = prefs.getDouble('totalEntries') ?? 0.0;
    });
  }

  // Função para adicionar um novo valor e salvar no SharedPreferences
  Future<void> _addEntry(double value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalEntries += value;  // Soma o novo valor ao total
    });
    await prefs.setDouble('totalEntries', totalEntries);  // Salva o novo total
  }


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
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Informe o valor de ',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4180AB),
                ),
                children: [
                  TextSpan(
                    text: 'entrada',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF72C96A), // Cor verde, mesma do botão
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
                labelText: "R\$",
                labelStyle: TextStyle(
                  color: Color(0xFFBDD1DE),
                  fontSize: 18,
                ),
              ),
              keyboardType: TextInputType.number,
              style: GoogleFonts.inter(
                fontSize: 18,
                color: Colors.black,
              ),
              onChanged: (value) {
                setState(() {
                  entry = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categoria',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4180AB),
                  ),
                ),
                ListTile(
                  title: const Text('Categoria 1'),
                  leading: Radio<String>(
                    value: 'Categoria 1',
                    groupValue: selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Categoria 2'),
                  leading: Radio<String>(
                    value: 'Categoria 2',
                    groupValue: selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Outros'),
                  leading: Radio<String>(
                    value: 'Outros',
                    groupValue: selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: ()  async {
                  await _addEntry(entry);
                  Navigator.pushNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF72C96A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Adicionar'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
