part of 'props_provider.dart';

/// A request for a selective rebuild based on the selected data.
/// Used internally by [PropsSelect].
class Aspect<Props extends PropsProvider<Props>, Data extends Object?> {
  Aspect(this.selector);

  /// Extracts the data this aspect cares about.
  final Data Function(Props item) selector;

  /// Returns true if this aspect's data changed between prev and next.
  bool shouldNotify(
    Props prev,
    Props next,
  ) =>
      selector(prev) != selector(next);
}
