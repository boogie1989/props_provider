library;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

part 'aspect.dart';
part 'of.dart';
part 'read.dart';
part 'select.dart';

abstract class PropsProvider<Child extends PropsProvider<Child>>
    extends InheritedModel<_Aspect<PropsProvider<Child>, Object?>> {
  ///
  ///
  ///
  const PropsProvider({super.key, required super.child});

  ///
  ///
  ///
  @override
  bool updateShouldNotify(covariant PropsProvider<Child> oldWidget) {
    return oldWidget != this &&
        const ListEquality().equals(oldWidget.equalityProps, equalityProps);
  }

  @override
  bool updateShouldNotifyDependent(
    covariant PropsProvider<Child> oldWidget,
    Set<_Aspect<PropsProvider<Child>, Object?>> dependencies,
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
