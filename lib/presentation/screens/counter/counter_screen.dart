import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';

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
    final int clickCounter = ref.watch( counterProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text("counter_screen"),
      ),
      body: Center(
          child:
              Text("Valor: $clickCounter", style: Theme.of(context).textTheme.titleLarge)),
      floatingActionButton:
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: colors.primary ,
            child:  const Icon(Icons.add),
          ),
    );
  }
}
