import 'package:comptador_provider/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModificaComptador extends StatelessWidget {
  const ModificaComptador({super.key});

  @override
  Widget build(BuildContext context) {
    // Definin una referència a l'estat
    final counter = Provider.of<Counter>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Accedim directament a l'estat a través de la referència
          Text(
            'Valor del comptador: ${counter.count}',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                // Accedim als mètodes de la mateixa manera
                onPressed: () => counter.increment(),
                child: const Text('Incrementar'),
              ),
              ElevatedButton(
                onPressed: () => counter.decrement(),
                child: const Text('Decrementar'),
              ),
              ElevatedButton(
                onPressed: () => counter.reset(),
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
