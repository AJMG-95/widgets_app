import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/router/app_router.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

void main() {
  runApp(
    //* ProviderScope es un tipo de widget especial que va a mantener una
    // * Refeerencia a todos los providers que se utilicen
    // * Gracias a ProviderScope riverpod va a saber donde buscar los providers
    // * que se vayan creando (providers de riverpod)
    const ProviderScope(child: MainApp() )
  );

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Widgets',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 8).getTheme(),
    );
  }
}
