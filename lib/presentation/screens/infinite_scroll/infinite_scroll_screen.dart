import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {
  static const name = "infinite_scroll_screen";
  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {
  List<int> imagesIds = [0, 1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      /* appBar: AppBar(
        title: const Text('InfiniteScroll'),
      ), */

      //* Este widget MediaQuery.removePadding sirve para elimiar la barra superior
      // * donde se muestra la bateria, notificaiones etc.
      // * Y casos de otros móviles tambien la barrrar inferior
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
          //* El builer hace que los elementos se construyan bajo demanda, y no tener el
          // * Screen con todos los elementos cargados, ya que sería poco eficiente
          // * El builer sabe cuando estan apunto de entrar en pantalla para así generarlos
          // * Tambien maneja en caché las imagenes por lo que no se van a perder (es muy eficiente)
        child: ListView.builder(
          //* indica la cantidad de elementos que se deben/pueden cargar
          itemCount: imagesIds.length,
          //* Construye los elementos a cargar
          itemBuilder: (context, index) {
          // * Permite cargar una imagen y mientras se carga la imagen muestra un placeholder
          return FadeInImage(
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
            placeholder: const AssetImage('assets/images/jar-loading.gif'),
            image: NetworkImage(
                'https://picsum.photos/id/${imagesIds[index]}/500/300'),
          );
          }
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(),
        backgroundColor: colors.primary,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
