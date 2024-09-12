import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      action: SnackBarAction(
        label: 'Acción',
        onPressed: () {},
      ),
      // Indica el tiempo maximo en el que se muestra el snackbar:
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

//* Recibe el build context ya que es de donde se recibe colores, posición, etc...
  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      //* Esto obliga a que el usuario cierre el dialog desde uno de los botones del mismo,
      //* es decir no se cierra al pulsar fuera del dialog
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('¿Estas seguro?'),
        content: const Text(
            'Do ea Lorem voluptate incididunt tempor amet excepteur aute veniam aute elit. Do nostrud ad excepteur mollit id consectetur. Ad nisi fugiat aliqua voluptate sint pariatur eu commodo aliqua magna non. Nulla consequat fugiat ea sit. Elit sit ut id ad ut. Consequat anim laborum irure qui consequat reprehenderit Lorem sint'),
        actions: [
          TextButton(
            // Se usa context.pop() gracias a la dependencia de go_router,
            // En caso de no disponer de la dependencia, se usa Navigator.of(context).pop()
            onPressed: () => context.pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(onPressed: () => context.pop(), child: const Text('Aceptar'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars & Dialogs'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
                onPressed: () {
                  //* Este es un método que trae flutter para mostrar las licencias de las dependencias usadas
                  showAboutDialog(context: context, children: [
                    const Text(
                        'lorem ipsum dolor sit amet. Amet ut aute laborum velit ipsum aliqua incididunt nostrud. Excepteur incididunt dolore veniam fugiat incididunt ea velit ullamco. Excepteur quis incididunt ad consequat ut sunt cillum sunt esse deserunt Lorem exercitation reprehenderit laborum.'),
                  ]);
                },
                child: const Text('Licencias usadas')),
            FilledButton.tonal(
                onPressed: () => openDialog(context),
                child: const Text('Mostrar Dialog')),
          ],
        ),
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
