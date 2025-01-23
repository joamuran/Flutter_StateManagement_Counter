import 'package:comptador_bloc/bloc/counter_bloc.dart';
import 'package:comptador_bloc/screens/modifica_comptador.dart';
import 'package:comptador_bloc/screens/mostra_comptador.dart';
import 'package:flutter/material.dart';

class CounterHomePage extends StatefulWidget {
  @override
  State<CounterHomePage> createState() => _CounterHomePageState();
}

class _CounterHomePageState extends State<CounterHomePage> {
  final CounterBloc _bloc = CounterBloc(); // Instància del Bloc
  int _currentIndex = 0; // Índex de la pestanya seleccionada

  @override
  void dispose() {
    _bloc.dispose(); // Desinstanciem el Bloc quan el widget es destrueix
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      ModificaComptador(
        bloc: _bloc, // Passem el Bloc al widget
      ),
      MostraComptador(
        bloc: _bloc, // Passem el Bloc al widget
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? 'Edita el comptador'
              : 'Mostra el comptador', // Canvia el títol segons la pestanya
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Actualitzem la pestanya seleccionada
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.visibility),
            label: 'Mostra',
          ),
        ],
      ),
      body: screens[_currentIndex], // Mostra la pantalla corresponent
    );
  }
}
