library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'aspect.dart';
part 'of.dart';
part 'read.dart';
part 'select.dart';

/// Base class for providing immutable "props" down the widget tree
/// with fine-grained rebuilds powered by [InheritedModel].
///
/// "Props" should be immutable data objects. Descendants can:
///  - read props ([PropsOf])
///  - read non-dependently ([PropsRead])
///  - subscribe to selected prop changes only ([PropsSelect])
abstract class PropsProvider<Child extends PropsProvider<Child>>
    extends InheritedModel<Aspect<PropsProvider<Child>, Object?>> {
  /// Create a props provider.
  /// Wrap the subtree that needs access to these props.
  const PropsProvider({super.key, required super.child});

  /// Called on every rebuild to decide if *any* dependent should rebuild.
  ///
  /// Default logic:
  ///  - rebuild if key changed (provider replaced)
  ///  - rebuild if any identityProps changed
  @override
  bool updateShouldNotify(covariant PropsProvider<Child> oldWidget) {
    return key != oldWidget.key ||
        listEquals(oldWidget.identityProps, identityProps) == false;
  }

  /// Called to decide if *selected* dependents (based on aspects)
  /// should rebuild.
  ///
  /// Each dependent registers specific [Aspect]s and is only rebuilt
  /// if at least one aspect’s selector output changed.
  @override
  bool updateShouldNotifyDependent(
    covariant PropsProvider<Child> oldWidget,
    Set<Aspect<PropsProvider<Child>, Object?>> dependencies,
  ) {
    for (final aspect in dependencies) {
      if (aspect.shouldNotify(oldWidget, this)) {
        return true;
      }
    }
    return false;
  }

  /// List of fields used to detect global provider changes,
  /// independent of aspects.
  ///
  /// Override to include props that should cause a full dependents rebuild
  /// when changed.
  @protected
  List<Object?> get identityProps;
}
