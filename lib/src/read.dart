part of 'inherited_params.dart';

///
///
///
class Read<Params extends InheritedParams<Params>> {
  const Read();

  Params call(BuildContext context) {
    final params = context.findAncestorWidgetOfExactType<Params>();
    assert(params != null, 'No $Params found in context');
    return params!;
  }

  Params? maybe(BuildContext context) {
    return context.findAncestorWidgetOfExactType<Params>();
  }
}
