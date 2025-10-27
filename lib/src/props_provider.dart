library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'aspect.dart';
part 'of.dart';
part 'read.dart';
part 'select.dart';

abstract class PropsProvider<Child extends PropsProvider<Child>>
    extends InheritedModel<Aspect<PropsProvider<Child>, Object?>> {
  ///
  ///
  ///
  const PropsProvider({super.key, required super.child});

  ///
  ///
  ///
  @override
  bool updateShouldNotify(covariant PropsProvider<Child> oldWidget) {
    return key != oldWidget.key ||
        listEquals(oldWidget.identityProps, identityProps) == false;
  }

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

  @override
  bool isSupportedAspect(Object aspect) =>
      aspect is Aspect<PropsProvider<Child>, Object?>;

  @protected
  List<Object?> get identityProps;
}
