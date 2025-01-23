# Gestió de l'estat amb BLoC

Compartició d'estat entre components: Els patrons com Provider o Riverpod permeten compartir l'estat de forma fàcil entre diferents parts de l'aplicació, sense passar manualment les funcions o les dades.
Modularitat: La separació clara entre la lògica de l'estat i la interfície d'usuari facilita l'extracció de widgets i la reutilització.
Control granular de re-renderitzacions: Amb aquests patrons, només es reconstrueixen les parts necessàries de la interfície d'usuari, millorant així el rendiment.
Testabilitat millorada: Com que la lògica de l'estat està separada, es pot provar de forma independent de la interfície d'usuari.
Exemple pràctic de limitació amb setState
En el context del teu projecte, si vols extreure una gran part de la interfície d'usuari o necessites compartir l'estat del comptador amb més pantalles, notaràs que setState requereix molta feina manual per passar funcions i dades entre components. Amb Provider o Riverpod, aquest problema desapareix, ja que el comptador estaria disponible globalment sense dependre d'una classe concreta.



Explicació del Codi
CounterBloc:

Gestiona l'estat del comptador.
Utilitza un StreamController per emetre el valor del comptador cada vegada que canvia.
Proporciona mètodes (increment, decrement, reset) per modificar el valor del comptador i enviar-lo a través del Stream.
StreamBuilder:

S'utilitza en els widgets ModificaComptador i MostraComptador per escoltar els canvis al comptador.
Reactivament actualitza la interfície d'usuari cada vegada que el Bloc emet un nou valor.
Gestió del Bloc:

Es crea una instància de CounterBloc en la classe _CounterHomePageState.
El Bloc es passa als widgets ModificaComptador i MostraComptador mitjançant el constructor.
Disposem del Bloc al mètode dispose per alliberar recursos i evitar fuites de memòria.
Reutilització de components:

Els widgets ModificaComptador i MostraComptador són independents i reutilitzen el mateix Bloc.
Avantatges d'aquesta implementació
Separació de responsabilitats:
La lògica de l'estat es manté al Bloc, separada de la interfície d'usuari.
Reactivitat:
Qualsevol canvi al comptador es reflecteix automàticament gràcies als Streams i StreamBuilder.
Escalabilitat:
Aquesta estructura facilita afegir més funcionalitats o pantalles sense duplicar codi.



OJO !! No funciona correctament amb la segona vista

```mermaid
classDiagram
    class CounterBloc {
        -int _counter
        -StreamController<int> _counterController
        +Stream<int> counterStream
        +increment() void
        +decrement() void
        +reset() void
        +dispose() void
    }

    class CounterApp {
        <<StatelessWidget>>
        +CounterApp()
        +build(BuildContext context) Widget
    }

    class CounterHomePage {
        <<StatefulWidget>>
        +createState() State<CounterHomePage>
    }

    class _CounterHomePageState {
        <<State<CounterHomePage>>>
        -int _currentIndex
        -CounterBloc _bloc
        +build(BuildContext context) Widget
        +dispose() void
    }

    class ModificaComptador {
        <<StatelessWidget>>
        +ModificaComptador()
        +build(BuildContext context) Widget
    }

    class MostraComptador {
        <<StatelessWidget>>
        +MostraComptador()
        +build(BuildContext context) Widget
    }

    CounterApp "1" --> "1" CounterHomePage
    CounterHomePage "1" --> "1" _CounterHomePageState
    _CounterHomePageState "1" --> "1" CounterBloc
    _CounterHomePageState "1" --> "1" ModificaComptador
    _CounterHomePageState "1" --> "1" MostraComptador
    CounterBloc "1" --> "many" ModificaComptador : Stream<int>
    CounterBloc "1" --> "many" MostraComptador : Stream<int>

```


```mermaid
sequenceDiagram
    participant User as Usuari
    participant CounterApp as CounterApp
    participant _CounterHomePageState as _CounterHomePageState
    participant CounterBloc as CounterBloc
    participant ModificaComptador as ModificaComptador
    participant MostraComptador as MostraComptador

    User ->> CounterApp: Interacció inicial
    CounterApp ->> _CounterHomePageState: Inicialitza Bloc i construcció inicial
    _CounterHomePageState ->> ModificaComptador: Passa el Bloc

    User ->> ModificaComptador: Prem "Incrementar"
    ModificaComptador ->> CounterBloc: Crida a increment()
    CounterBloc ->> CounterBloc: Actualitza _counter
    CounterBloc ->> ModificaComptador: Emissió del nou valor (Stream)
    ModificaComptador ->> ModificaComptador: Mostra el valor actualitzat

    User ->> BottomNavigationBar: Canvia de pestanya
    _CounterHomePageState ->> MostraComptador: Passa el Bloc

    User ->> MostraComptador: Consulta el comptador
    MostraComptador ->> CounterBloc: Escolta el valor actual (Stream)
    CounterBloc ->> MostraComptador: Retorna el valor actual
    MostraComptador ->> MostraComptador: Mostra el valor del comptador

```