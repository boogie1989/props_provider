part of 'inherited_params.dart';

class ParamsAspect<
  Params extends InheritedParams<Params>,
  Data extends Object?
> {
  ParamsAspect(
    this.selector, {
    bool Function(Params prev, Params next)? shouldNotify,
  }) : _shouldNotify = shouldNotify;

  final Data Function(Params item) selector;
  final bool Function(
    Params prev,
    Params next,
  )?
  _shouldNotify;

  bool shouldNotify(
    Params prev,
    Params next,
  ) => _shouldNotify?.call(prev, next) ?? (selector(prev) != selector(next));
}
