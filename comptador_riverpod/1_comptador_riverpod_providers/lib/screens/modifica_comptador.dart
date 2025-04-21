import 'package:comptador_riverpod/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModificaComptador extends ConsumerWidget {
  const ModificaComptador({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch escolta l'estat del counterProvider
    // i reconstrueix el widget quan aquest estat canvia
    final counter = ref.watch(counterProvider); // Exemples 1 i 2
    //final counter = ref.watch(counterNotifierProvider); // Exemple 3

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Valor del comptador: $counter', // Mostrem el valor actual del comptador (reactiu)
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                // ref.read accedeix al notifier del StateProvider
                // i permet modificar l'estat directament sense subscriure's
                onPressed: () => {
                  ref.read(counterProvider.notifier).state++, // Exemple 2
                  // ref.read(counterNotifierProvider.notifier).incrementa() // Exemple 3
                },
                child: const Text('Incrementar'),
              ),
              ElevatedButton(
                onPressed: () => {
                  ref.read(counterProvider.notifier).state--, // Exemple 2
                  // ref.read(counterNotifierProvider.notifier).decrementa() // Exemple 3
                },
                child: const Text('Decrementar'),
              ),
              ElevatedButton(
                onPressed: () => {
                  ref.read(counterProvider.notifier).state = 0, // Exemple 2
                  //ref.read(counterNotifierProvider.notifier).reset() // Exemple 3
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
