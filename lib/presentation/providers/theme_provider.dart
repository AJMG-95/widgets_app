import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

// Lista de colores inmutable
//* Provider: Es para valores inmutables
final colorListProvider = Provider<List<Color>>((ref) => colorList);

// Estado => isDarkModeProvider = boolean
//* StateProvider: Para mantener el estado de valores mutables (variables/objetos simples)
final isDarkModeProvider = StateProvider<bool>((ref) => false);

//  Indeice el color del tema seleccionado
final selectedIndexColorProvider = StateProvider<int>((ref) => 0);

// Objeto de tipo AppTheme (custom)
//* StateNotifierProvider: Es para mantener estados de objetos más elaborados
// StateNotifierProvider, requiiere dos campos, la clase encargada de
//  manejar el notifier->ThemeNotifier  y la clase de la que va a manejar
//  el estado->AppTheme(instancia de AppTheme)
final appThemeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  //Regresa un instancia, en estecaso de ThemeNotifier que es la que incializa el tema -> super(AppTheme())
  (ref) => ThemeNotifier(),
);

//Controller o Notifier
//* Es para controlar el tema, Este se va a encargar de mantener el estado
// * de una instancia del AppTheme
class ThemeNotifier extends StateNotifier<AppTheme> {
  //El constructor crea una instancia del AppTheme
  ThemeNotifier() : super(AppTheme()); // STATE = Estado = new AppTheme();

  //* Dentro de esta clase se va a tener acceso a todas las propiedades de la
  // * clase AppTheme (lib\config\theme\app_theme.dart)

  void toggledDarkMode() {
    //  El nuevo estado es una copia del esta actual pero con el valor opuesto del isDarkMode
    // Riverpod se da cuenta de la asignacion del nuevo estrado y se encarga de hacer la notificación
    //  a todos los widgets donde sea necesario
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int index) {
    state = state.copyWith(selectedColor: index);
  }
}
