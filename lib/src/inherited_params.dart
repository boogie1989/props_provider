library;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

part 'aspect.dart';
part 'of.dart';
part 'read.dart';
part 'select.dart';

abstract class InheritedParams<Child extends InheritedParams<Child>>
    extends InheritedModel<ParamsAspect<InheritedParams<Child>, Object?>> {
  ///
  ///
  ///
  const InheritedParams({super.key, required super.child});

  ///
  ///
  ///
  @override
  bool updateShouldNotify(covariant InheritedParams<Child> oldWidget) {
    return oldWidget != this &&
        const ListEquality().equals(oldWidget.equalityProps, equalityProps);
  }

  @override
  bool updateShouldNotifyDependent(
    covariant InheritedParams<Child> oldWidget,
    Set<ParamsAspect<InheritedParams<Child>, Object?>> dependencies,
  ) {
    for (final aspect in dependencies) {
      if (aspect.shouldNotify(oldWidget, this)) {
        return true;
      }
    }

    return false;
  }

  @protected
  List<Object?> get equalityProps;
}
