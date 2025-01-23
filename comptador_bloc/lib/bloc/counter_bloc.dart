import 'dart:async';

class CounterBloc {
  // Valor del comptador (aquest és l'estat del BLoC)
  int _counter = 0;
  int get counter => _counter; //Getter

  /* 
    Implementació del patró Singleton: 
     
     Singleton = Constructor privat + instància estàtica
  */

  static CounterBloc? _counterBLoC;

  // Constructor de factoría: Retorna una instància del comptador
  factory CounterBloc() {
    _counterBLoC ??= CounterBloc._();
    return _counterBLoC!;
  }

  // Constructor privat (en aquest cas no té cos)
  CounterBloc._();

  /* Fi de la definició del patŕo Singleton */

  // Ara ja comencem la funcionalitat pròpia de BLoC amb Streams

  // StreamController per gestionar el comptador
  final _counterController = StreamController<int>.broadcast();

  // Getters per obtenir els Stream i escoltar els canvis al comptador
  Stream<int> get counterStream => _counterController.stream;

  // Funcions per modificar el comptador
  void increment() {
    _counter++;
    // Una vegada incrementem el comptador,
    // enviem el valor d'aquest pel sink de l'stream
    _counterController.sink.add(_counter);
  }

  void decrement() {
    // Decrementem i enviem el valor per l'stream
    _counter--;
    _counterController.sink.add(_counter);
  }

  void reset() {
    // Ressetegem i enviem el valor per l'stream
    _counter = 0;
    _counterController.sink.add(_counter);
  }

  // Tancar el StreamController per evitar fuites (fugues) de memòria
  void dispose() {
    // El mètode dispose s'invoca quan desinstanciem la classe
    _counterController.close();
  }
}
