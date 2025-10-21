library;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'aspect.dart';
part 'of.dart';
part 'read.dart';
part 'select.dart';

class _Equatable extends Equatable {
  const _Equatable(this.props);

  @override
  final List<Object?> props;
}

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
        _Equatable(oldWidget.equilityProps) != _Equatable(equilityProps);
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

  List<Object?> get equilityProps => [];
}
