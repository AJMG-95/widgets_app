import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {
  static const name = "theme_changer_screen";
  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /* final bool isDarkMode = ref.watch(isDarkModeProvider); */
    final bool isDarkMode = ref.watch(appThemeNotifierProvider).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Changer'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            onPressed: () {
              /* ref.read(isDarkModeProvider.notifier).update((state) => !state); */
              ref.read(appThemeNotifierProvider.notifier).toggledDarkMode();
            },
          )
        ],
      ),
      body: const ThemeChangerView(),
    );
  }
}

class ThemeChangerView extends ConsumerWidget {
  const ThemeChangerView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Color> colors = ref.watch(colorListProvider);
    /* final int selectedColor = ref.watch(selectedIndexColorProvider); */
    final int selectedColor = ref.watch(appThemeNotifierProvider).selectedColor;

    return ListView.builder(
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final color = colors[index];
          return RadioListTile(
              title: Text(
                'Este color',
                style: TextStyle(color: color),
              ),
              subtitle: Text('${color.value}'),
              activeColor: color,
              value: index,
              groupValue: selectedColor,
              onChanged: (value) {
                /* ref.read(selectedIndexColorProvider.notifier).state = index; */
                ref
                    .read(appThemeNotifierProvider.notifier)
                    .changeColorIndex(index);
              });
        });
  }
}
