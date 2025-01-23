import 'package:comptador_bloc/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';

class MostraComptador extends StatelessWidget {
  final CounterBloc bloc;

  const MostraComptador({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<int>(
        stream: bloc.counterStream,
        initialData: bloc.counter, // Inicialitzem el valor al comptador
        builder: (context, snapshot) {
          return Text(
            'Comptador: ${snapshot.data}',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          );
        },
      ),
    );
  }
}
