import 'package:flutter/widgets.dart';

typedef ChoiceListBuilder = Widget Function(
  IndexedChoiceItemBuilder itemBuilder,
  int itemCount,
);

typedef IndexedChoiceItemBuilder = Widget Function(int index);

typedef ChoiceItemBuilder = Widget Function();

typedef ChoiceSkipCallback<T> = bool Function(
  String? keyword,
  int index,
);
