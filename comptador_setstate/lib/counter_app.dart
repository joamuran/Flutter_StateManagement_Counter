import 'package:flutter/material.dart';

// L'aplicació de comptador serà un giny amb estat
class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

// Classe de l'estat de l'aplicació
class _CounterAppState extends State<CounterApp> {
  // L'estat ara compta amb l'índex de la barra de navegació
  // i l'estat del comptador
  int _currentIndex = 0;
  int _counter = 0;

  // Funció per incrementar el comptador
  // Cal fer-les dins el setState per marcar l'estat
  // com a dirty i forçar el build

  void _incrementCounter() {
    setState(() {
      _counter++; // Actualitza l'estat del comptador.
    });
  }

  // Funció per decrementar el comptador.
  void _decrementCounter() {
    setState(() {
      _counter--; // Actualitza l'estat del comptador.
    });
  }

  // Funció per resetejar el comptador.
  void _resetCounter() {
    setState(() {
      _counter = 0; // Posa el comptador a zero.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Llista de pantalles disponibles al BottomNavigationBar.
    final List<Widget> screens = [
      // Primera pantalla (editar el comptador).
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Valor del comptador: $_counter',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Text('Incrementar'),
                ),
                ElevatedButton(
                  onPressed: _decrementCounter,
                  child: const Text('Decrementar'),
                ),
                ElevatedButton(
                  onPressed: _resetCounter,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
      // Segona pantalla (mostrar el comptador).
      Center(
        child: Text(
          'Comptador: $_counter',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? 'Edita el comptador'
              : 'Mostra el comptador', // Canvia el títol segons la vista actual.
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Índex seleccionat actual.
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Actualitza l'índex segons la selecció.
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
      body: screens[
          _currentIndex], // Mostra la pantalla corresponent a l'índex actual.
    );
  }
}
