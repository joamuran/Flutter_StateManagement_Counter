import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_notifier.g.dart'; // Fitxer generat automàticament

@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void incrementa() => state++;
  void decrementa() => state--;
  void reset() => state = 0;
}
