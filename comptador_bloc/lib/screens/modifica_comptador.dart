import 'package:comptador_bloc/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';

class ModificaComptador extends StatelessWidget {
  final CounterBloc bloc;

  const ModificaComptador({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<int>(
            stream: bloc.counterStream,
            initialData: bloc.counter,
            builder: (context, snapshot) {
              return Text(
                'Valor del comptador: ${snapshot.data}',
                style: const TextStyle(fontSize: 24),
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: bloc.increment,
                child: const Text('Incrementar'),
              ),
              ElevatedButton(
                onPressed: bloc.decrement,
                child: const Text('Decrementar'),
              ),
              ElevatedButton(
                onPressed: bloc.reset,
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
