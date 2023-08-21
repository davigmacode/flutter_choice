import 'package:flutter/widgets.dart';
import 'controller.dart';

typedef ChoiceModalProviderBuilder<T> = Widget Function(
  ChoiceModalController<T> modal,
  Widget? child,
);

typedef ChoiceModalStateBuilder<T> = Widget Function(
  ChoiceModalController<T> modal,
);

typedef IndexedChoiceModalStateBuilder<T> = Widget Function(
  ChoiceModalController<T> modal,
  int i,
);

typedef ChoiceFilterStateBuilder = Widget Function(
  ChoiceFilterController filter,
);

typedef ChoiceModalClose = void Function({
  bool confirmed,
  VoidCallback? onClosed,
});
