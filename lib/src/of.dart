part of 'props_provider.dart';

/// Reads the current [PropsProvider] and marks the widget as dependent.
///
/// Causes rebuild when [PropsProvider.updateShouldNotifyDependent] returns true.
class PropsOf<Props extends PropsProvider<Props>> {
  const PropsOf();

  /// Read provider and register as dependent.
  Props call(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<Props>();
    assert(result != null, 'No $Props found in context');
    return result!;
  }

  /// Nullable variant. Returns null if not found.
  Props? maybe(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Props>();
}
