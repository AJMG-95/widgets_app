import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonsScreen extends StatelessWidget {
  static const String name = "ButtonsScreen";

  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons Screen'),
      ),
      body: const _ButtonsView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {context.pop()},
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
          ],
        ),
      ),
    );
  }
}
