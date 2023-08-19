import 'package:flutter/widgets.dart';
import 'controller.dart';

typedef ChoiceModalBuilder<T> = Widget Function(
  ChoiceModalController<T> state,
  Widget? child,
);

typedef ChoiceModalStateBuilder<T> = Widget Function(
  ChoiceModalController<T> state,
);

typedef ChoiceFilterStateBuilder = Widget Function(
  ChoiceFilterController state,
);
