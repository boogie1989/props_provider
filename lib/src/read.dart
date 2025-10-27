part of 'props_provider.dart';

/// Reads the current [PropsProvider] *without* dependency.
/// Will NOT trigger rebuilds when provider updates.
class PropsRead<Props extends PropsProvider<Props>> {
  const PropsRead();

  /// Read provider without subscribing to updates.
  Props call(BuildContext context) {
    final params = context.findAncestorWidgetOfExactType<Props>();
    assert(params != null, 'No $Props found in context');
    return params!;
  }

  /// Nullable variant. Returns null if not found.
  Props? maybe(BuildContext context) {
    return context.findAncestorWidgetOfExactType<Props>();
  }
}
