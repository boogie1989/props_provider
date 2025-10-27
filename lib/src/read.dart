part of 'props_provider.dart';

///
///
///
class PropsRead<Props extends PropsProvider<Props>> {
  const PropsRead();

  Props call(BuildContext context) {
    final params = context.findAncestorWidgetOfExactType<Props>();
    assert(params != null, 'No $Props found in context');
    return params!;
  }

  Props? maybe(BuildContext context) {
    return context.findAncestorWidgetOfExactType<Props>();
  }
}
