part of 'props_provider.dart';

class PropsOf<Props extends PropsProvider<Props>> {
  const PropsOf();

  Props call(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<Props>();
    assert(result != null, 'No $Props found in context');
    return result!;
  }

  Props? maybe(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Props>();
}
