import 'package:flutter_riverpod/flutter_riverpod.dart';

/*

// Exemple 1. Un Provider per proveïr un estat simple

final counterProvider = Provider((ref) {
  return 0;
});

// Fi Exemple 1

*/

// Exemple 2: Definim un StateProvider per gestionar un estat simple (un enter en aquest cas)
// StateProvider encapsula un valor mutable que es pot modificar directament
final counterProvider = StateProvider<int>((ref) => 0);


// Fi Exemple 2

/*
// Exemple 3. Un Provider dins un Notifier

class CounterNofifier extends Notifier<int> {
  // Iniicialització de l'estat
  @override
  int build() {
    return 0;
  }

  void incrementa() {
    state++;
  }

  void decrementa() {
    state--;
  }

  void reset() {
    state = 0;
  }
}

final counterNotifierProvider = NotifierProvider<CounterNofifier, int>(() {
  return CounterNofifier();
});
*/