import 'package:comptador_provider/screens/modifica_comptador.dart';
import 'package:comptador_provider/screens/mostra_comptador.dart';
import 'package:flutter/material.dart';

class CounterHomePage extends StatefulWidget {
  @override
  State<CounterHomePage> createState() => _CounterHomePageState();
}

class _CounterHomePageState extends State<CounterHomePage> {
  int _currentIndex = 0; // Índex de la pestanya seleccionada

  @override
  Widget build(BuildContext context) {
    final screens = [
      ModificaComptador(),
      MostraComptador(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? 'Edita el comptador'
              : 'Mostra el comptador', // Canvia el títol segons la pestanya
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Actualitzem la pestanya seleccionada
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.visibility),
            label: 'Mostra',
          ),
        ],
      ),
      body: screens[_currentIndex], // Mostra la pantalla corresponent
    );
  }
}
