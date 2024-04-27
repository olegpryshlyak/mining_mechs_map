import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension UiContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colors => Theme.of(this).colorScheme;

  TextTheme get styles => Theme.of(this).textTheme;


  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;

  double get defaultViewPortFraction => 1 - (36 / MediaQuery.of(this).size.width);

  EdgeInsets get inputScrollPadding =>
      EdgeInsets.only(top: MediaQuery.viewInsetsOf(this).top, bottom: MediaQuery.viewInsetsOf(this).bottom - 40);
}

extension BlocContext on BuildContext {
  T cubit<T>() => Provider.of<T>(this, listen: false);
}

extension AutoRouteContext on BuildContext {
  AutoRoutePage? get previousRoute {
    AutoRoutePage? _previousRoute;
    final _stack = router.stack;
    if (_stack.length >= 2) {
      _previousRoute = _stack[_stack.length - 2];
    }
    return _previousRoute;
  }
}
