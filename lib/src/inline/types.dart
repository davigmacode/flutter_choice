import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';

typedef ChoiceListBuilder = Widget Function(
  IndexedChoiceItemBuilder itemBuilder,
  int itemCount,
);

typedef IndexedChoiceItemBuilder = Widget Function(int index);

typedef ChoiceGroupBuilder = Widget Function(
  IndexedChoiceItemBuilder itemBuilder,
  int itemCount,
);

typedef IndexedChoiceGroupItemBuilder = Widget Function(int index);

typedef ChoiceGroupItemBuilder = Widget Function(Widget header, Widget body);

typedef ChoiceGroupHeaderBuilder<T> = Widget Function(
  String name,
  List<int> indices,
);

typedef ChoiceItemBuilder = Widget Function();

typedef ChoiceSkipResolver<T> = bool Function(
  ChoiceController<T> state,
  int index,
);

typedef ChoiceGroupResolver = String Function(int index);

typedef ChoiceGroupSortResolver = int Function(String a, String b);
