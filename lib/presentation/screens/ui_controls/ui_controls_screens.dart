import 'package:flutter/material.dart';

class UiControlsScreens extends StatelessWidget {
  static const name = "ui_controls_screen";
  const UiControlsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Controls'),
      ),
      body: const _UiControlsView(),
    );
  }
}

class _UiControlsView extends StatefulWidget {
  const _UiControlsView();

  @override
  State<_UiControlsView> createState() => _UiControlsViewState();
}

// Este enumerable es para definir los valoes del RadioListTile
enum Transportation { car, plane, boat, submarine }

class _UiControlsViewState extends State<_UiControlsView> {
  bool isDeveloper = true;
  Transportation selectedTransportation = Transportation.car;
  bool wantsBreakfast = true;
  bool wantsLunch = false;
  bool wantsDinner = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        //* Funciona como un swich normal pero ocupa todo el ancho de la pantalla, e
        //* incluye titulo y subtitulo. Reacciona al pulsar en cualquier parte del espacio ocupado.
        SwitchListTile(
            title: const Text('Developer Mode'),
            subtitle: const Text('Controles adicionales'),
            value: isDeveloper,
            onChanged: (value) => setState(() {
                  isDeveloper = !isDeveloper;
                })),

        ExpansionTile(
          title: const Text('Vehiculo de transporte'),
          subtitle: Text('$selectedTransportation'),
          children: [
            RadioListTile(
                title: const Text('By Car'),
                subtitle: const Text('Viajar en coche'),
                value: Transportation.car,
                groupValue: selectedTransportation,
                onChanged: (value) => setState(() {
                      selectedTransportation = Transportation.car;
                    })),
            RadioListTile(
                title: const Text('By Boat'),
                subtitle: const Text('Viajar en barco'),
                value: Transportation.boat,
                groupValue: selectedTransportation,
                onChanged: (value) => setState(() {
                      selectedTransportation = Transportation.boat;
                    })),
            RadioListTile(
                title: const Text('By Plane'),
                subtitle: const Text('Viajar en avión'),
                value: Transportation.plane,
                groupValue: selectedTransportation,
                onChanged: (value) => setState(() {
                      selectedTransportation = Transportation.plane;
                    })),
            RadioListTile(
                title: const Text('By Submarine'),
                subtitle: const Text('Viajar en submarino'),
                value: Transportation.submarine,
                groupValue: selectedTransportation,
                onChanged: (value) => setState(() {
                      selectedTransportation = Transportation.submarine;
                    }))
          ],
        ),

        ExpansionTile(
          title: const Text('Comidas'),
          subtitle: Text('${wantsBreakfast ? "Desayuno" : ""}'
              '${wantsBreakfast && (wantsLunch || wantsDinner) ? " | " : ""}'
              '${wantsLunch ? "Almuerzo" : ""}'
              '${wantsLunch && wantsDinner ? " | " : ""}'
              '${wantsDinner ? "Cena" : ""}'),
          children: [
            CheckboxListTile(
                title: const Text('¿Quiere desayuno?'),
                value: wantsBreakfast,
                onChanged: (value) => setState(() {
                      wantsBreakfast = !wantsBreakfast;
                    })),
            CheckboxListTile(
                title: const Text('¿Quiere almuerzo?'),
                value: wantsLunch,
                onChanged: (value) => setState(() {
                      wantsLunch = !wantsLunch;
                    })),
            CheckboxListTile(
                title: const Text('¿Quiere cena?'),
                value: wantsDinner,
                onChanged: (value) => setState(() {
                      wantsDinner = !wantsDinner;
                    }))
          ],
        )
      ],
    );
  }
}
