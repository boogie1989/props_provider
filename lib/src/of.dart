part of 'inherited_params.dart';

class Of<Params extends InheritedParams<Params>> {
  const Of();

  Params call(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<Params>();
    assert(result != null, 'No $Params found in context');
    return result!;
  }

  Params? maybe(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Params>();
}
