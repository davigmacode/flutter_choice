import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';

typedef ChoiceListBuilder = Widget Function(
  IndexedChoiceBuilder itemBuilder,
  int itemCount,
);

typedef IndexedChoiceBuilder = Widget Function(int index);

typedef IndexedChoiceStateBuilder<T> = Widget Function(
  ChoiceSelectionController<T> state,
  int index,
);
