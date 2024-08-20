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

class AppTutorialScreen extends StatelessWidget {
  static const name = "tutorial_screen";
  const AppTutorialScreen({super.key});

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
          )
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
