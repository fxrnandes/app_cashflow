import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome_screen.dart';
import 'screens/name_input_screen.dart';
import 'screens/salary_input_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CashflowApp());
}

class CashflowApp extends StatelessWidget {
  const CashflowApp({super.key});

  Future<bool> verificarPrimeiraVez() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') == null; // Verifica se o nome já foi salvo
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: verificarPrimeiraVez(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Mostra um indicador de carregamento
        } else {
          final isFirstTime = snapshot.data ?? true;
          return MaterialApp(
            title: 'Cashflow',
            theme: ThemeData(
              textTheme: GoogleFonts.interTextTheme(),
            ),
            initialRoute: isFirstTime ? '/' : '/home',
            routes: {
              '/': (context) => const WelcomeScreen(),
              '/name': (context) => const NameInputScreen(),
              '/salary': (context) => const SalaryInputScreen(),
              '/home': (context) {
                final arguments = ModalRoute.of(context)!.settings.arguments;
                final userName = arguments != null
                    ? arguments as String
                    : 'Usuário';
                return HomeScreen(userName: userName);
              },
            },
          );
        }
      },
    );
  }
}
