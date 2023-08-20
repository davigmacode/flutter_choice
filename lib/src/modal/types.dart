import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';
import 'controller.dart';

typedef ChoiceModalBuilder<T> = Widget Function(
  ChoiceModalController<T> modal,
  Widget? child,
);

typedef ChoiceModalStateBuilder<T> = Widget Function(
  ChoiceSelectionController<T> selection,
  ChoiceModalController<T> modal,
);

typedef IndexedChoiceModalStateBuilder<T> = Widget Function(
  ChoiceSelectionController<T> selection,
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
