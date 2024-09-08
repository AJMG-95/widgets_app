import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

//* Extender ConsumerWidget en lugar de StatelessWidget, que es expuesto por Riverpod
class CounterScreen extends ConsumerWidget {
  static const String name = "counter_screen";
  const CounterScreen({super.key});

  //* el builder de un ConsumerWidget, ofrece la referencia a un WidgetRef,
  // * que es como decirle a riverpod que se va a ocupar la referencia a
  // * algún provider de riverpod
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    //* Aqui es donde se espercifica el provider que se va a usar
    // ref.watch hace que se esté a la "escucha" del provider, y cada vez
    //que este cambie, automaticamente flutter va a tomar el nuevo valor/stado
    // no usar el watch Dentro de métodos
    final int clickCounter = ref.watch(counterProvider);
    final bool isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("counter_screen"),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ?
              Icons.dark_mode_outlined
              : Icons.light_mode_outlined
            ),
            onPressed: () {
              ref.read( isDarkModeProvider.notifier ).update((isDarkModeState) => !isDarkModeState);
            } ,
          )
        ],
      ),
      body: Center(
          child: Text("Valor: $clickCounter",
              style: Theme.of(context).textTheme.titleLarge)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //* Dentro de métodos se usa read en lugar de watch ya que ahí no se redibuja nada
          // * por lo que solo se necesita leer el valor del counterProvider.
          //* Usualmente para hacer un cambio en el valor del estado, se usa .notifier
          // * para que se realice la notificación.
          // * Y se usa .state para acceder directamente al estado y así poder modificarlo
          ref.read(counterProvider.notifier).state++;
          //* Otra forma de actualizar un estado es aplicando un .update
          // La decision entre .state++ y .update((state) => state+1) depende de la que
          // se ajuste más a lo que se desee hacer
          /* ref.read(counterProvider.notifier).update((state) => state+1); */
        },
        backgroundColor: colors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
