import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//* Esto es una clase que define y perite instanciar un tipo de objeto concreto
//* Además crea instancias del mismo, por ello estas clases suelen crearse en los assets
class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(this.title, this.caption, this.imageUrl);
}

final slides = <SlideInfo>[
  SlideInfo(
      'Busca la comida',
      'Excepteur voluptate sint qui commodo elit cillum excepteur labore. Sint proident elit ipsum cillum tempor adipisicing culpa. Elit id cillum anim ad ut non reprehenderit. Aute ea quis anim Lorem qui nisi.',
      'assets/images/1.png'),
  SlideInfo(
      'Entrega rápida',
      'Lorem amet non aute anim magna qui sint deserunt do Lorem aliquip ullamco. Magna ipsum do non enim id incididunt fugiat incididunt enim voluptate proident velit laboris commodo. Ea sunt reprehenderit reprehenderit nostrud do ut ea incididunt qui et aliquip aliquip. Sunt id minim esse reprehenderit. Eu et laborum irure eiusmod ad minim quis. Eu tempor eiusmod cillum ut mollit.',
      'assets/images/1.png'),
  SlideInfo(
      'Disfruta la comida',
      'Enim excepteur reprehenderit excepteur cupidatat. Veniam quis nisi eiusmod veniam dolore veniam aliquip consectetur minim velit. Dolor non culpa laborum aliquip non non aliquip aute elit duis exercitation cillum incididunt culpa.',
      'assets/images/1.png'),
];

class AppTutorialScreen extends StatefulWidget {
  static const name = "tutorial_screen";
  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {
  //* El PageController, sabe el espacio que ocupa el pageView, si se está moviendo, etc.
  // * Para usar un controlador es necesario que el widget sea un StatefulWidget,
  // * Y asi poder crear el controlador en el state del widget
  final PageController pageViewController = PageController();

  //* Bandera booleana para indicar que se ha alcanzado el último slide
  bool endReached = false;

  //* Para agregar un listener al PageController se debe usar el ciclo de vida del StatefulWidget,
  // * initState, dispose, etc.

  @override
  void initState() {
    super.initState();

    //* Añade el listener al PageController
    // * el listener addListener, es una función void, que no requiere nada ni devuelve nada
    // * esto ocurre porque toda la información se encuentra en el PageController()
    pageViewController.addListener(() {
      //! 0jo: el indide de las paginas no son números (1,2,3) enteros sino double
      // !  (1.0,...,1.5...,2.0), ya que durante el cambio de página hay un punto
      // ! en el que se ven dos páginas
      /* debugPrint('PÁGINA ${pageViewController.page}'); */

      final page = pageViewController.page ?? 0;
      if (!endReached && page >= (slides.length - 1.5)) {
        setState(() {
          endReached = true;
        });
      }
    });
  }

  //* Cada vez que se coloque un listener o se use un controlador es buena practica
  // * usar un dispose, para limpiar el contexto de listeners y controladores, y así
  // * no gastar más memoria de la necesaria
  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //* un PageView ocupa todo el alto y todo el ancho de la pantalla y
          // * permite hacer scroll en una de las dos direcciones, por defecto
          // * Horizontal pero se puede especificar mediante scrollDirection
          PageView(
            controller: pageViewController,
            physics: const BouncingScrollPhysics(),
            children: slides
                .map((slideData) => _Slide(
                    title: slideData.title,
                    caption: slideData.caption,
                    imageUrl: slideData.imageUrl))
                .toList(),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => context.pop(),
              child: const Text('Salir'),
            ),
          ),

          //* Usa un operador ternario para mostrar el widget. Se suele usar SizedBox vacío,
          // * para mostrar un widget de 0px's
          endReached
              ? Positioned(
                  bottom: 30,
                  right: 30,
                  //* El botón aparece muy abruptamente, es por ello que se va a usar el paquete
                  // * animate_do, para mostrarlo con una animación "sencilla"
                  child: FadeInRight(
                    //* El from le inica que solo se mueva x unidades
                    from: 15,
                    delay: const Duration(milliseconds: 500),
                    child: FilledButton(
                      onPressed: () => context.pop(),
                      child: const Text('Comenzar'),
                    ),
                  ))
              : const SizedBox(),
        ],
      ),
    );
  }
}

//* Para widgets sin estado, es conveniente crear StatelessWidget
class _Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String imageUrl;

  const _Slide(
      {required this.title, required this.caption, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(imageUrl),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              title,
              style: titleStyle,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(caption, style: captionStyle),
          ],
        ),
      ),
    );
  }
}
