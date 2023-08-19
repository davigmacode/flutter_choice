import 'package:flutter/widgets.dart';
import 'controller.dart';

typedef ChoiceSelectionBuilder<T> = Widget Function(
  ChoiceSelectionController<T> state,
  Widget? child,
);

typedef ChoiceStateBuilder<T> = Widget Function(
  ChoiceSelectionController<T> state,
);
