part of 'props_provider.dart';

/// Selects part of the props and registers only to that value.
/// Rebuilds only when the selected value changes.
class PropsSelect<Props extends PropsProvider<Props>> {
  const PropsSelect();

  /// Select a value and subscribe to changes of that value only.
  V call<V extends Object?>(
    BuildContext context,
    V Function(Props item) selector,
  ) {
    final aspect = Aspect<Props, V>(selector);
    final model = InheritedModel.inheritFrom<Props>(
      context,
      aspect: aspect,
    );

    assert(model != null, 'No $Props found in context');
    return aspect.selector(model!);
  }

  /// Nullable variant. Returns null if provider not found.
  V? maybe<V extends Object?>(
    BuildContext context,
    V Function(Props item) selector,
  ) {
    final aspect = Aspect<Props, V>(selector);
    final model = InheritedModel.inheritFrom<Props>(
      context,
      aspect: aspect,
    );
    return model == null ? null : aspect.selector(model);
  }
}
