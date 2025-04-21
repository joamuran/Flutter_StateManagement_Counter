import 'package:comptador_riverpod/screens/counter_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importem flutter_riverpod

// Widget principal
void main() {
  // Envoltem l'aplicació amb un ProviderScope
  // ProviderScope inicialitza Riverpod i gestiona el cicle de vida dels providers
  runApp(const ProviderScope(child: CounterApp()));
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comptador amb Riverpod',
      home: CounterHomePage(),
    );
  }
}
