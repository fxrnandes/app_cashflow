import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  ExpenseScreenState createState() => ExpenseScreenState();
}

class ExpenseScreenState extends State<ExpenseScreen> {
  double expenseValue = 0.0;
  String selectedCategory = 'Despesa fixa';

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
                    text: 'saída',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFE65F5F), // Cor vermelha, mesma do botão
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
                  expenseValue = double.tryParse(value) ?? 0.0;
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
                  title: const Text('Despesa fixa'),
                  leading: Radio<String>(
                    value: 'Despesa fixa',
                    groupValue: selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Lazer'),
                  leading: Radio<String>(
                    value: 'Lazer',
                    groupValue: selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Investimento'),
                  leading: Radio<String>(
                    value: 'Investimento',
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
                onPressed: () {
                  // Lógica para salvar a saída
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
