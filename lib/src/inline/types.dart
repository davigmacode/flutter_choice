import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';

typedef ChoiceListBuilder = Widget Function(
  IndexedChoiceItemBuilder itemBuilder,
  int itemCount,
);

typedef IndexedChoiceItemBuilder = Widget Function(int index);

typedef ChoiceItemBuilder = Widget Function();

typedef ChoiceSkipCallback<T> = bool Function(
  ChoiceController<T> state,
  int index,
);
