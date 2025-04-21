## Comptador amb anotacions (Exemple 4)

Als exemples anteriors hem vist com crear `NotifierProvider` de manera manual, definint la classe `Notifier`, el mètode `build` i després instanciant-la amb `NotifierProvider`.

Ara bé, Riverpod ens proporciona una alternativa molt més senzilla i elegant basada en **anotacions**, que utilitza la llibreria de generació de codi per fer tota aquesta part automàticament.

Aquest sistema es basa en les **Riverpod annotations** i en l'ordre `build_runner`, que genera automàticament els *Providers* i altres elements associats.

> [!NOTE] 
> **Sobre la generació de codi**
> 
> En Dart, existeixen llibreries que poden **generar automàticament codi font** a partir d'anotacions especials. Aquest procés s'anomena **generació de codi**.
>
> Per tal que aquest codi es genere correctament, cal:
> 
> - Incorporar les anotacions pertinents (en el nostre cas `@riverpod`)
> - Afegir una línia `part 'nom_del_fitxer.g.dart';` al nostre arxiu, indicant on s'ha de generar el codi.
> - Executar l'ordre `flutter pub run build_runner build`, que analitza el projecte i crea automàticament els fitxers `.g.dart`.
> El fitxer `.g.dart` generat **no s'ha de modificar manualment**, ja que s'actualitza cada vegada que tornem a executar `build_runner`.
> Aquesta tècnica és molt útil per evitar haver d'escriure codi repetitiu, i s'utilitza en moltes llibreries avançades de Flutter, com la llibrería Floor per a les bases de dades SQLite.

### Instal·lant les anotacions de Riverpod

Per fer ús d'aquest sistema, hem d'instal·lar alguns paquets addicionals:

```bash
flutter pub add riverpod_annotation
flutter pub add --dev build_runner riverpod_generator
```

Amb això incorporem la llibreria `riverpod_annotation` al projecte, i les llibreries de desenvolupament `build_runner` i `riverpod_generator`. La diferència és que aquestes últimes ens proporcionen utilitats que només utilitzarem quan estem desenvolupant l'aplicació.

També necessitarem fer servir l'ordre `part` per enllaçar els fitxers generats automàticament.

### Creant el Notifier amb anotacions

Anem a definir un comptador igual que abans, però ara fent ús de la classe `@riverpod`.

Primer, creem el fitxer `counter_notifier.dart` dins de `providers`, i escrivim:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_notifier.g.dart'; // Fitxer generat automàticament

@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void incrementa() => state++;
  void decrementa() => state--;
  void reset() => state = 0;
}
```

Amb això:

- La classe `Counter` hereta de `_$Counter`, que serà la classe generada per `build_runner`.
- La funció `build()` proporciona el valor inicial, igual que abans.
- Hem declarat mètodes per modificar l'estat igual que a l'exemple 3, però ara amb molta menys cerimònia.

> [!TIP]
> **Què fa exactament `@riverpod`?**
> 
> Quan utilitzem l’anotació `@riverpod`, estem indicant a Riverpod que:
> 
> - Volem **crear un Provider automàticament** a partir de la classe o funció anotada.
> - El nom del Provider es generarà automàticament a partir del nom de la classe o funció.
> - El fitxer `.g.dart` contindrà el codi necessari per registrar i gestionar aquest Provider.
> 
> Per exemple, si tenim:
> 
> ```dart
> @riverpod
>  class Counter extends _$Counter { ... }
> ```

> Riverpod generarà un Provider anomenat `counterProvider`, que podrem utilitzar amb `ref.watch(counterProvider)` o `ref.read(counterProvider.notifier)`.
> 

### Generant el codi

Una vegada definida i anotada la classe, hem de generar el fitxer `.g.dart` des de l'arrel amb:

```bash
dart run build_runner build
```

Això crearà automàticament el provider `counterProvider` a partir de la nostra classe `Counter` (aquest es guardarà a la carpeta `build/generated`, pel que no el veurem directament).


> [!TIP]
> **El mode watch**
> 
> Podem executar el *build runner* en mode watch amb:
> 
> ```
> dart run build_runner watch --delete-conflicting-outputs
> ```
> Amb això aconseguim que cada vegada que es produisca un canvi en les classes anotades, es regenere automàticament el fitxer `.g.dart`.
> 


> [!TIP] 
> **Reiniciant l'Analysis Server**
> 
> Sovint, quan treballem amb fitxers generats es produeix una situació de dessincronització de l'entorn. Tot i que les aplicacions funcionen correctament, VSCode no detecta els fitxers `.g.dart` generats i marca com a errònies determinades referències a classes que sí existeixen.
> Per tal de resoldre aquest problema de sincronització, ens hem d'assegurar de generar primer que res els fitxers `.g.part` amb el `build runner`, o millor executant-lo en mode `watch`. Després, podem reiniciar l'anàlisi del projecte, accedint a la paleta d'ordres ( `Ctrl` + `Shift` + `P`), i llançant l'ordre `Dart: Restart Analysis Server`.
> Amb això els errors deurien desaparéixer. En cas de no fer-ho, podriem intentar reiniciar completament VSCode.
> 

### Utilitzant-lo en un widget

Ara que tenim el `counterProvider` generat, podem fer-lo servir exactament igual que abans:

```dart
class ModificaComptador extends ConsumerWidget {
  const ModificaComptador({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Valor del comptador: $counter'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => ref.read(counterProvider.notifier).incrementa(),
              child: const Text('Incrementar'),
            ),
            ElevatedButton(
              onPressed: () => ref.read(counterProvider.notifier).decrementa(),
              child: const Text('Decrementar'),
            ),
            ElevatedButton(
              onPressed: () => ref.read(counterProvider.notifier).reset(),
              child: const Text('Reset'),
            ),
          ],
        )
      ],
    );
  }
}
```

### Conclussions finals

Les anotacions de Riverpod ens aporten diversos avantatges:

* Simplifica la declaració dels `Notifiers`, de manea que les declaracions són més netes.
* Separa la lògica de negoci de la instanciació, i elimina la necessitat d'instanciar manualment els providers.
* El codi generat és clar i segur, i ens prepara el projecte pe a una millor escalabilitat.

Aquest és l'enfocament que sol recomanar-se per a projectes mitjans o grans.