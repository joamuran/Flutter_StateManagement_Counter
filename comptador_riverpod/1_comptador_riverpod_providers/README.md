# comptador_riverpod

Podriem dir que Riverpod és l'evolució de Provider. De fet, el seu nom és un anagrama d'aquest. Un dels prinicpals avantatges de Riverpod respecte al seu predecessor, Provider és que Riverpod no depèn del context de Flutter. És a dir, es tracta d'una llibreria que podem utilitzar, per exemple en projectes Dart directament.

L'objectiu dels gestors d'estats és oferir-nos una mena d'estat global compartit. En Riverpod, aquest estat s'ofereix a través dels Providers. Els [Providers](https://riverpod.dev/es/docs/concepts/providers) són objectes que encapsulen l'estat, i permeten que aquest s'escolte en diverses ubicacions de l'aplicació.

Ara bé, els Providers [poden ser de diversa naturalesa](https://riverpod.dev/es/docs/concepts/providers#tipos-diferentes-de-providers), per exemple:

* Providers de només lectura, que permeten l'accés a determinat estat senzill o calculat,
* NotifierProviders, que ens permeten realitzar canvis a l'estat i notificar aquests canvis a altres ginys que consumeixen aquest estat per a la seua reconstrucció,
* Providers que treballen amb dades asíncrones (ja siguen Futures o Streams), etc.

## Instal·lant Riverpod

A la [documentació sobre Riverpod](https://riverpod.dev/es/docs/introduction/getting_started#installing-the-package) se'ns comenten els diferents paquets que componen Riverpod.

Per al nostre exemple del comptador, només necessitarem la llibreria `flutter_riverpod`. Per instal·lar aquesta, des de la terminal:

```bash
flutter pub add flutter_riverpod
```

## counterProvider

Per al comptador farem ús d'un Provider que emmagatzeme un estat senzill: `StateProvider`. 

Definirem aquest en la carpeta `providers`, amb el nom `counter_provider.dart`, de la següent manera:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = Provider((ref) {
  return 0;
});
```

Aquest és el Provider més senzill que podem implementar, el qual, proveeix un valor d'estat de només lectura a qualsevol widget que el vulga consumir. Per a això, proporcionem al Provider una funció com argument. Aquesta funció rebrà un argument, anomenat `ref`, que de moment no utilitzarem. En el cos de la funció, el que farem serà retornar el valor que desitgem proveïr, en aquest cas un 0.

Aquest serà doncs el patró general per als diferents tipus de Providers, i que senzillament consisteix en definir el valor d'estat que volem proveïr, ja siga n valor emmagatzemat en l'estat o calculat a partir d'aquest.

## Consumint el valor del Provider

Per tal de poder consumir l'estat proporcionat per qualsevol *Provider* en una aplicació, hem d'afegir `ProviderScope` a l'arrel de l'arbre de widgets d'aquesta. Això permet inicialitzar Riverpod i gestionar els cicles de vida dels providers, i qualsevol widget que utilitzem a l'arbre, podrà consumir les dades dels Providers.

```dart
void main() {
  runApp(const ProviderScope(child: CounterApp()));
}
```

Per tal de consumir Providers en un widget, la llibreria *Provider* ens proporciona el widget de tipus `ConsumerWidget`. Aquest és equivalent a un `StatelessWidget`, amb la diferència que incorpora un paràmetre `ref` addicional en el mètode `build`. Aquest paràmetre ens servirà per tal d'accedir als Providers.

Aleshores, el que hem de fer és fer ús de `ConsumerWidget` en lloc d'`StatelessWidget`.

!!!note "I si és un StatefulWidget?"
     En cas de voler utilitzar algun Provider en un `StatefulWidget`+`State`, farem ús de les classes `ConsumerStatefulWidget` i `ConsumerState`. En aquest cas, `ref` serà una propietat del propi estat.

El paràmetre `ref`,  de tipus `WidgetRef`, conté diversos mètodes, ja siga pe actualitzar dades o escoltar canvis en les dades del *Provider* quan es produeixen, i reconstruir el giny en conseqüència.

Amb això, tindrem un codi semblant a aquest en la vista:

```dart
class VisualitzaComptador extends ConsumerWidget {
  const VisualitzaComptador({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch escolta l'estat del counterProvider
    // i reconstrueix el widget quan aquest estat canvia
    final counter = ref.watch(counterProvider);

    return Center(
        ...
          Text(
            // Mostrem el valor actual del comptador (reactiu)
            'Valor del comptador: $counter', 
          ),
        ...
    );
  }
}

```

Com veiem:

* La classe `visualitzaComptador` extén de la classe de `ConsumerWidget`, 
* En el mètode `build` tenim com a argument `WidgetRef ref`
* Amb `ref.watch(counterProvider)` observem el Provider `counterProvider`, de manera que si aquest valor canvia, el widget es torna a construir.

Aquesta seria la forma més senzilla d'ús d'un Provider, la qual ens serveix per tal de consultar un valor constant o derivet d'un altre, però no ens aprofita si el que volem és modificar aquest valor com és el cas del comptador.

## Modificant el valor dels providers amb StateProvider (Exemple 2)

Hem vist que `Provider` ens serveix per mantenir un estat, però no ens permet modificar aquest. Per tal de modificar aquest estat de manera simple, podem fer ús del *Provider* `StateProvider`.

Aquest nou *Provider* conté una propietat `state` que permet emmagatzemar i accedir a l'estat, fent-lo adequat per a casos on volem mantindre un valor d'estat mutable senzill, com és el cas del comptador.

### Declarant un StateProvider

El Provider `StateProvide` es defineix de manera semblant a un `Provider`, però en aquest cas farem ús de la classe `StateProvider<T>`, on `T` és el tipus genèric de dades que volem emmagatzemar. Per exemple, si volem crear un comptador enter, podem definir-lo així:

```dart
final counterProvider = StateProvider<int>((ref) => 0);
```

Aquesta línia crea un Provider que conté un enter (0 inicialment). A diferència del `Provider` anterior, aquest estat **es pot modificar**.


### Accedint als mètodes a través del Notifier

Al mètode `build` del `ConsumerWidget`, hem vist com rebem un objecte `WidgetRef ref`, que utilitzem per tal d'accedir als *Providers*.

Aquest objecte `ref` ens proporciona diversos mètodes. Entre aquests ja hem vist el mètode `watch` per llegir el valor actual del proveïdor i reconstruir el widget quan aquest canvie. També tenim el mètode `listen`, que és molt semblant, però no reconstrueix el widget, sinò que llança una funció determinada quan l'estat canvia.

El mètode que ens interessa ara és `read`, que obté el valor de l'estat, sense *enganxar-se* a escoltar-lo.

!!!tip "Els mètodes watch i read"
     - `ref.watch(...)` serveix per **observar** els canvis de l’estat, i reconstruir automàticament el widget quan aquest estat canvia.
     - `ref.read(...)` s’utilitza quan **només volem accedir o modificar** el valor de l’estat, però sense escoltar-ne els canvis.

Aquuest mètode `read` serà el que utilitzem habitualmen per tal d'accedir a l'estat del Provider, a través de la propietat `notifier` del Provider:

```dart
ref.read(counterProvider.notifier)
```

Tot i que aprofundirem després amb aquests *notifiers* podem avançar que es tracta de classes que tenen la capacitat de notificar a altres classes del seu estat intern. Així, amb aquesta línia `ref.read(counterProvider.notifier)`, el que fem és accedir al **gestor intern de l’estat** del `counterProvider`, el qual ens permet llegir i modificar el valor actual mitjançant la propietat `state`.

Així doncs, quan volguem modificar el valor del comptador davant cert esdeveniment (per exemple el botó d'incrementar), farem:

```dart
ElevatedButton(
  onPressed: () => {
    ref.read(counterProvider.notifier).state++, 
    },
  )
```

## Modificant el valor dels Providers amb NotifyProvider (Exemple 3)

Ja hem vist com modificar l'estat del Provider com a reacció a un event, com puga ser fer clic en el botó d'incrementar o decrementar el comptador, mitjançant la propietat `state` del gestor d'estat intern del Provider.

Per a casos més complexos que modificar un simple enter, com siga la gestió de llistes, per exemple per gestionar un carret de la compra, necessitarem alguns mecanismes més complets que els que ens proporciona `StateProvider`.

Al nostre exemple, anem a seguir modificant el comptador, però ara, en lloc de modificar directament l'estat, implementarem funcions en algun lloc que s'encarreguen d'actualitzar l'estat i que els widgets *consumidors* se n'adonen d'aquests canvis. Aquest procediment serà fàcilment exportable a altres estats més complexos.

Per a això farem ús d'un *Provider* especial: el **`NotifyProvider`**, que té la capacitat de notificar els *listeners* i *consumidors* d'aquest.

Veiem com fer-ho.

### CounterNotifier

A la carpeta de `providers` generem la següent classe:

```dart
class CounterNofifier extends Notifier<int> {
    // Inicialització de l'estat

    // Mètodes d'actualització de l'estat

}
```

Aquesta classe deriva de la calsse `Notifier`, de la llibreria *Provider*, i té la capacitat d'emetre *notificacions* d'estat als widgets consumidors. Concretament, el tipus de valor d'estat que notificarà serà un *int*, que és el tipus al que parametritzem la classe.

Aquesta classe contindrà bàsicament una inicialització de l'estat, i després oferirà mètodes per actualitzar aquest.

**És important destacar que aquesta classe NO és un Provider en sí, i que aquest el definirem després**.

La classe *Notifier*, per altra banda, ens obliga a proporcionar una implementació del mètode `build`. Aquest mètode ens servirà per a la inicialització, i el seu tipus de retorn serà el mateix amb el què hem parametritzat el `Notifier`:

```dart

// Iniicialització de l'estat
@override
  int build() {
    return 0;
  }
```

Com veiem, el que fem és retornar el valor 0, que serà el valor inicial de, comptador.

Una vegada tenim aquesta classe, ja podem crear el *Provider*, el qual, en lloc de proporcionar-nos un valor d'estat simple, ens proporcionarà un *Notifier*; concretament, una instància de la classe `CounterNotifier` que hem creat anteriorment. Per tant, aquest NotifierProvider és un genèric parametritzat amb dos tipus: la classe `CounterNotifier`, i el tipus que aquest proporciona, en aquest cas, un `int`:

```dart
final counterNotifierProvider = NotifierProvider<CounterNofifier, int>(...);
```

El constructor de `NotifierProvider`, igual que féiem amb un `Provider` senzill, rep com a argument una funció que ens retorna el seu valor inicial, concretament, una instància de `CounterNotifier`:

```dart
final counterNotifierProvider = NotifierProvider<CounterNofifier, int>(() {
  return CounterNofifier();
});

```

### Accedint al valor de l'estat

Ara, per accedir al valor de l'estat, des dels mateixos `ConsumerWidgets`, el que farem serà escoltar aquest `counterNorifierProvider`:

```dart
final counter = ref.watch(counterNotifierProvider); // Exemple 3
```

Tot i que veurem el mateix valor que abans (un 0), el que estem consultant és el *Notifier* (en concret la instància del `counterNotifier`), que és qui ens retorna el 0 implementat al seu `build`.

### Mètodes incrementa, decrementa i reset

El proper pas és implementar al CounterNotifier els mètodes incrementa, decrementa i reset.

Recordem que la classe `Notifier` el que fa és exposar un **estat** que canvia amb el transcurs del temps. Aquest *estat* ve representat per la propietat `state` en la pròpia classe (al qual accedim de manera transparent a través d'un setter (`set state(tipus valor)` ). Aquest mètode fa que s'actualitzen els listeners si el valor de l'estat canvia.

Això doncs, aquests mètodes quedaran:

```dart

class CounterNofifier extends Notifier<int> {
  // Iniicialització de l'estat
  //...

  // Mètodes d'actualització de l'estat

  void incrementa() {
    state++;
  }

  void decrementa() {
    state--;
  }

  void reset() {
    state = 0;
  }
}
```

### Accedint als mètodes a través del Notifier

Al mètode `build` del `ConsumerWidget`, hem vist com rebem un objecte `WidgetRef ref`, que utilitzem per tal d'accedir als *Providers*.

Aquest objecte `ref` ens proporciona diversos mètodes. Entre aquests ja hem vist el mètode `watch` per llegir el valor actual del proveïdor i reconstruir el widget quan aquest canvie. També tenim el mètode `listen`, que és molt semblant, però no reconstrueix el widget, sinò que llança una funció determinada quan l'estat canvia.

El mètode que ens interessa ara és `read`, que obté el valor de l'estat, sense *enganxar-se* a escoltar-lo. 

Aquuest mètode `read` serà el que utilitzem habitualmen per tal d'accedir als mètodes implementats en el `Notifier`:

```dart
ref.read(Notifier)
```

A dins el `read`, necessitarem accedir al *Notifier*, però a través del provider *counterNotifierProvider*. Per a això, fem ús de la propietat `notifier` del Provider:

```dart
ref.read(CounterNotifierProvider.notifier)
```

Ara ja tenim una referència a aquest Notifier, i podem accedir als seus mètodes. Per exemple, per incrementar el comptador quan es prem el botó:

```dart
ElevatedButton(
  onPressed: () => {
    ref.read(counterNotifierProvider.notifier).incrementa()
  },
  child: const Text('Incrementar'),
}
```

Després de veure en essència com funcionen els Providers en Riverpod, podem veure com extreure'ls tot el partit amb anotacions al següent exemple.