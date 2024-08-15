import 'package:flutter/material.dart';

class SnackbarScreen extends StatelessWidget {
  static const name = "snackbar_screen";
  const SnackbarScreen({super.key});

  //* Crea un método para no sobrecargar la lógica en el onPress
  //* Se le pasa el contexto como argumento
  void showCustomSnackbar(BuildContext context) {
    /* Esto es para evitar que se muestren los snackbars
      uno tras otro al pulsar varias veces el botón */
    ScaffoldMessenger.of(context).clearSnackBars();

    final SnackBar snackbar = SnackBar(
      content: const Text('Hoa Mundo'),
      // Cualquier acción del snackbar hace que este se cierre:
      action: SnackBarAction(label: 'Acción', onPressed: () {},),
      // Indica el tiempo maximo en el que se muestra el snackbar:
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars & Dialogs'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar Snackbars'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        onPressed: () => showCustomSnackbar(context),
      ),
    );
  }
}
