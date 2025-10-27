import 'package:flutter/material.dart';
import 'package:props_provider/props_provider.dart';

class PropsProviderExample extends PropsProvider<PropsProviderExample> {
  const PropsProviderExample({
    super.key,
    required this.count,
  }) : super(
          child: const _PathProviderExample(),
        );

  final int count;

  @override
  List<Object?> get identityProps => [count];

  static const select = PropsSelect<PropsProviderExample>();
}

class _PathProviderExample extends StatelessWidget {
  static int _counter = 0;
  const _PathProviderExample();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Props Provider'),
        Text('Parent Updates: ${_counter++}'),
        const _CounterView(),
      ],
    );
  }
}

class _CounterView extends StatelessWidget {
  const _CounterView();

  @override
  Widget build(BuildContext context) {
    final count = PropsProviderExample.select(context, (p) => p.count);
    return Text('Props counter: $count');
  }
}
