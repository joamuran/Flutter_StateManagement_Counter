import 'package:comptador_provider/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModificaComptador extends StatelessWidget {
  const ModificaComptador({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Fem ús d'un Consumer de la llibreria Provider
          // parametritzat al model d'estat Counter
          Consumer<Counter>(
            // El paràmetre builder és qui reconstruieix el widget
            // cada vegada que s'invoca a ChangeNotifier
            // counter és el model d'estat que rebem,
            // child és un widget opcional, per a contingut no reactiu
            builder: (context, counter, child) {
              return Text(
                'Valor del comptador: ${counter.count}',
                style: const TextStyle(fontSize: 24),
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                // Com que no necessitem ser notificats dels canvis,
                // no cal fer ús de Consumer.
                // Per accedir a les funcionalitats del model d'estats
                // llegirem el Counter del context i invocarem als
                // mètodes oportuns
                onPressed: () => context.read<Counter>().increment(),
                child: const Text('Incrementar'),
              ),
              ElevatedButton(
                onPressed: () => context.read<Counter>().decrement(),
                child: const Text('Decrementar'),
              ),
              ElevatedButton(
                onPressed: () => context.read<Counter>().reset(),
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
