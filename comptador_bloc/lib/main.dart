import 'package:comptador_bloc/screens/counter_home_page.dart';
import 'package:flutter/material.dart';

// Widget principal
void main() => runApp(const CounterApp());

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comptador amb BLoC',
      home: CounterHomePage(),
    );
  }
}
