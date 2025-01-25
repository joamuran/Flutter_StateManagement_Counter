import 'package:flutter/material.dart';

// Aquest aclasse representa el model d'estats del comptador.
// No és el Provider en sí, encara que hem creat una carpeta providers.

// La classe es representa com un mixin amb ChangeNotifier
// Això ens proporciona el mètode notifyListeners.

class Counter with ChangeNotifier {
  // Valor del comptador
  int _count = 0;

  // Mètode getter per llegir el comptador
  int get count => _count;

  // Mètodes per interactuar amb el comptador
  void increment() {
    _count++;
    notifyListeners(); // Notifica els listeners del canvi
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}
