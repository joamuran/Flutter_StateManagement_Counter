import 'package:comptador_provider/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MostraComptador extends StatelessWidget {
  const MostraComptador({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<Counter>(builder: (context, counter, child) {
        return Text(
          'Comptador: ${counter.count}',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        );
      }),
    );
  }
}
