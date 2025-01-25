import 'package:comptador_provider/providers/counter_provider.dart';
import 'package:comptador_provider/screens/counter_home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Widget principal
void main() => runApp(ChangeNotifierProvider(
    create: (BuildContext context) => Counter(), child: const CounterApp()));

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comptador amb Provider',
      home: CounterHomePage(),
    );
  }
}
