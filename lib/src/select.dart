part of 'props_provider.dart';

class PropsSelect<Props extends PropsProvider<Props>> {
  const PropsSelect();

  V call<V extends Object?>(
    BuildContext context,
    V Function(Props item) selector, {
    bool Function(V prev, V next)? shouldNotify,
  }) {
    final data = maybe<V>(
      context,
      selector,
      shouldNotify: shouldNotify,
    );

    assert(data is V, 'No $Props found in context');
    return data as V;
  }

  V? maybe<V extends Object?>(
    BuildContext context,
    V Function(Props item) selector, {
    bool Function(V prev, V next)? shouldNotify,
  }) {
    final aspect = Aspect<Props, V>(
      selector,
      shouldNotify: shouldNotify == null
          ? null
          : (prev, next) => shouldNotify(
                selector(prev),
                selector(next),
              ),
    );

    final model = InheritedModel.inheritFrom<Props>(
      context,
      aspect: aspect,
    );

    return model == null ? null : aspect.selector(model);
  }
}
