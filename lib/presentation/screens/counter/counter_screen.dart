import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  static const String name = "counter_screen";
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("counter_screen"),
      ),
      body: Center(
        child: Text(
          "Valor",
          style: Theme.of(context).textTheme.titleLarge
        )
      ),
      floatingActionButton:
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {}
          ),
    );
  }
}
