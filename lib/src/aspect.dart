part of 'props_provider.dart';

class Aspect<Props extends PropsProvider<Props>, Data extends Object?> {
  Aspect(
    this.selector, {
    bool Function(Props prev, Props next)? shouldNotify,
  }) : _shouldNotify = shouldNotify;

  final Data Function(Props item) selector;
  final bool Function(
    Props prev,
    Props next,
  )? _shouldNotify;

  bool shouldNotify(
    Props prev,
    Props next,
  ) =>
      _shouldNotify?.call(prev, next) ?? (selector(prev) != selector(next));
}
