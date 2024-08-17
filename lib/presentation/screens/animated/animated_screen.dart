import 'package:flutter/material.dart';
import 'dart:math' show Random;

class AnimatedScreen extends StatefulWidget {
  static const name = "animated_screen";
  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  double width = 50;
  double height = 50;
  Color color = Colors.indigo;
  double borderRadius = 20;

  void _changeShape() {
    final random = Random();

    width = random.nextInt(300) + 120;
    height = random.nextInt(300) + 120;
    borderRadius = random.nextInt(100) + 20;
    color = Color.fromRGBO(random.nextInt(255), random.nextInt(255),
        random.nextInt(255), 1);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aniated Container'),
      ),
      body: Center(
        // Es igual que un container pero con animación
        child: AnimatedContainer(
          // Determina la duración de la animación
          duration: const Duration(milliseconds: 400),
          // Determina el efecto de la animación
          curve: Curves.elasticOut,
          width: width <= 0 ? 0 : width,
          height: height <= 0 ? 0 : height,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(borderRadius <= 0 ? 0 : borderRadius)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _changeShape(),
        backgroundColor: colors.primary,
        child: const Icon(
          Icons.play_arrow_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
