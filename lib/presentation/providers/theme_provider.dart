import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

// Estado => isDarkModeProvider = boolean
final isDarkModeProvider = StateProvider<bool>((ref) => false);

// Lista de colores inmutable
final colorListProvider = StateProvider<List<Color>>((ref) => colorList);

//  Indeice el color del tema seleccionado
final selectedIndexColorProvider = StateProvider<int>((ref) => 0);
