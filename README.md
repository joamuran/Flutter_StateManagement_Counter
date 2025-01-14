# Gesió de l'estat

Anem a veure, a través de quatre exemples diferents diferents formes de gestionar l'estat de les nostres aplicacions amb Flutter.

Per a això agafarem com a exemple una aplicació senzilla, inspirada en el comptador que implementa Flutter de manera predeterminada, però afegint dues vistes:

* Una **primera vista** que **modifica l'estat** de l'aplicació, és a dir, dóna la possibilitat d'*incrementar*, *decrementar* i *ressetejar* el comptador,
* Una **segona vista**, que serveix per **consultar l'estat**, o el que és el mateix, mostrar el valor del comptador.
* Ambdues vistes estaran disponibles des d'una vista principal, i podrem alternar entre elles mitjançant una barra de navegació inferior.

La idea és que qualsevol modificació de l'estat que es realitze s'aplique de manera rectiva a ambdues pantalles.

## El cicle de vida dels widgets i gestió de l'estat

Quan parlem de gestió de l'estat en Flutter, és important entendre com aquests canvis d'estat es reflecteixen de manera reactiva a la interfície d'usuari. Flutter aconsegueix això a través del **sistema de renderitzat** i l'ús de la propietat **dirty** dins del cicle de vida d'un widget.

### Què significa que un widget siga "dirty"?

Quan vam tractar el [cicle de vida dels widgets](https://joamuran.net/curs24_25/pmdm/u3/3.3.CicleVida/), vam veure que quan canviem l'estat d'un widget, aquest es marca com a **dirty** (brut) per indicar al framework que cal actualitzar-lo.
  
Quan això es produeix, Flutter executa un procés de **reconstrucció** en què només es redibuixen els **widgets marcats com dirty**, optimitzant així el rendiment de l'aplicació.

### el mètode `setState`

La classe [`State` ens ofereix el mètode `setState`](https://api.flutter.dev/flutter/widgets/State/setState.html) per tal de notificar al framework canvis en l'estat dels widgets.

Quan es produeix aquesta notificació, el framework marca el widget corresponent com a *dirty*, i el redibuixa en el següent **frame del cicle de renderitzat**, assegurant que els canvis es reflecteixen visualment.

> **El flag *dirty* i el cicle de vida**
> Al llarg del seu cicle de vida, els widgets amb estat passen per diverses fases, com la **creació (`initState`)**, l'**actualització (`didUpdateWidget`)**, i la **destrucció (`dispose`)**.
>
> Quan un widget es redibuixa, no es torna a crear completament, sinó que només es reconstruïx la part afectada pels canvis d'estat (que està marcada com a *dirty*), i la resta d'elements es reutilitzen.

Al primer projecte dels exemples, [comptador_setstate](comptador_setstate), veurem com fem el canvi d'estat fent ús de `setState` i widgets amb estat, on el control recau totalment en el desenvolupador.

A la resta d'exemples, farem ús de patrons més avançats, com **BlOC**, **Provider** o **Riverpod**, on el procés de marcar widgets com dirty es gestiona de manera diferent, i encapsulen aquesta lògica per fer-la més modular i reutilitzable.
