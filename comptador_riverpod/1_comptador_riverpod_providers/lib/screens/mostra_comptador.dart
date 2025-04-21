import 'package:comptador_riverpod/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MostraComptador extends ConsumerWidget {
  const MostraComptador({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch escolta el valor del counterProvider
    final counter = ref.watch(counterProvider); // Exemples 1 i 2
    //final counter = ref.watch(counterNotifierProvider); // Exemple 3

    return Center(
      child: Text(
        'Comptador: $counter', // Mostrem el valor actual del comptador
        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
    );
  }
}
