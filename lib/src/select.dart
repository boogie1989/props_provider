part of 'inherited_params.dart';

class Select<Params extends InheritedParams<Params>> {
  const Select();

  V call<V extends Object?>(
    BuildContext context,
    V Function(Params item) selector, {
    bool Function(V prev, V next)? shouldNotify,
  }) {
    final data = maybe<V>(
      context,
      selector,
      shouldNotify: shouldNotify,
    );

    assert(data is V, 'No $Params found in context');
    return data as V;
  }

  V? maybe<V extends Object?>(
    BuildContext context,
    V Function(Params item) selector, {
    bool Function(V prev, V next)? shouldNotify,
  }) {
    final aspect = ParamsAspect<Params, V>(
      selector,
      shouldNotify: shouldNotify == null
          ? null
          : (prev, next) => shouldNotify(
                selector(prev),
                selector(next),
              ),
    );

    final model = InheritedModel.inheritFrom<Params>(
      context,
      aspect: aspect,
    );

    return model == null ? null : aspect.selector(model);
  }
}
