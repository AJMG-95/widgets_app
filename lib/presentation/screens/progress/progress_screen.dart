import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  static const name = "progress_screen";
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicators'),
      ),
      body: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            'CircularProgressIndicator',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          const CircularProgressIndicator(
            strokeWidth: 2.5,
            backgroundColor: Colors.black26,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'LinearProgressIndicator',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          //* El LinearProgressIndicator se pued encapsular en un sizebox
          //*  para limitar el espacio que ocupa
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: const LinearProgressIndicator(
              backgroundColor: Colors.black26,
              minHeight: 2.5,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'CircularProgressIndicator & LinearProgressIndicator (controlado)',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          const _ControlledProgressIndicator(),
        ],
      ),
    );
  }
}

class _ControlledProgressIndicator extends StatelessWidget {
  const _ControlledProgressIndicator();

  @override
  Widget build(BuildContext context) {
    //* El StreamBuilder es algo que se va a construir en tiempo de ejecución
    //* Una vez no se use el StreamBuilder, este destruye el widget y realiza el dispose del stream (deja de consumir memoria)
    return StreamBuilder(
      //* El StreamBuilder está asociado a un stream, que es un flujo de información
      //* Este stream, se basa en el periodic, es decir que cada periodo de tiempo (Duration) emite un valor (value)
      stream: Stream.periodic(const Duration(milliseconds: 300), (value) {
        //* El value se divide entre 100 para abarcar los valores desde 0.0 hasta 1.0
        return (value * 2) / 100;
        //* El takeWhile indica una condición a cumplir para seguir emitiendo valores
        //* En este caso se emite el value mientras sea menor a 100
      }).takeWhile((value) => value < 100),
      //* El StreamBuilder, requiere un builder que use el context y el snapshot
      //* El context es la información del arbol de widget (buildContext)
      //* El snapshot, nos indica el valor que tiene el stream
      builder: (context, snapshot) {
        final progressValue = snapshot.data ?? 0.0;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                value: progressValue,
                strokeWidth: 2,
                backgroundColor: Colors.black26,
              ),
              const SizedBox(
                width: 20,
              ),
              //* el Expanded toma todo el espacio que el widget padre le da al widget hijo
              Expanded(
                child: LinearProgressIndicator(
                  value: progressValue,
                  minHeight: 2.5,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
