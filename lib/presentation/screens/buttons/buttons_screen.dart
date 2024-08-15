import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonsScreen extends StatelessWidget {
  //* Esta variable estatica puede ser útil, por ejemplo,
  //* para identificar esta pantalla en rutas de navegación
  //* u otros lugares donde necesites un identificador único,
  //* sin la necesidad crear una instancia de la clase
  static const String name = "ButtonsScreen";

  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons Screen'),
      ),
      body: const _ButtonsView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {context.pop()},
        backgroundColor: colors.primary,
        child: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Wrap(
          spacing: 10,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {}, child: const Text('ElebatedButton')),
            const ElevatedButton(
                onPressed: null, child: Text('ElebatedButton disabled')),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.access_alarm_rounded),
              label: const Text('ElevatedButton.icon'),
            ),
            FilledButton(onPressed: () {}, child: const Text('FilledButton')),
            FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.accessibility_new),
                label: const Text('FilledButton.icon')),
            OutlinedButton(
              onPressed: () {},
              child: const Text('OutlinedButton'),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.terminal),
              label: const Text('OutlinedButton.icon'),
            ),
            TextButton(onPressed: () {}, child: const Text('TextButton')),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.account_box_outlined),
                label: const Text('TextButton.icon')),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.app_registration_rounded)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.app_registration),
              style: ButtonStyle(
                //! Ojo antes se usa sabe MaterialStatePropertyAll, pero eso ya está deprecated
                backgroundColor: WidgetStatePropertyAll(colors.primary),
                iconColor: const WidgetStatePropertyAll(Colors.white),
              ),
            ),
            //TODO: CustomButton
            const CustomButton(),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  // Acepta un callback nullable que se llamará al tocar el botón
  final VoidCallback? onTap;

  const CustomButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    //* ClipRRect sirge para implementar bordes redondeados
    //!Ojo es iportante que ClipRRect contenga un widget Material para asegurar que el recorte se aplique a todo el contenido
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: onTap != null ? colors.primary : colors.primary.withAlpha(127),
        //* InkWell es como un GestureDetector pero con splah efect al usar la propiedad onTap
        child: InkWell(
          onTap: onTap,
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child:
                  Text('CustomButton', style: TextStyle(color: Colors.white))),
        ),
      ),
    );
  }
}
