import 'package:flutter/material.dart';

class SimpleExample extends StatelessWidget {
  static int _counter = 0;

  const SimpleExample({
    super.key,
    required this.counter,
  });

  final int counter;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Props drilling'),
        Text('Parent Updates: ${_counter++}'),
        _CounterView(count: counter),
      ],
    );
  }
}

class _CounterView extends StatelessWidget {
  const _CounterView({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Props counter: $count');
  }
}
