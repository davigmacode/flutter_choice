import 'package:flutter/widgets.dart';
import 'controller/main.dart';

typedef ChoiceBuilder<T> = Widget Function(
  ChoiceController<T> state,
  Widget? child,
);

typedef ChoiceStateBuilder<T> = Widget Function(
  ChoiceController<T> state,
);

typedef IndexedChoiceStateBuilder<T> = Widget Function(
  ChoiceController<T> state,
  int index,
);
