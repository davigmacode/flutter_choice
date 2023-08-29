import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';

typedef ChoiceAnchorBuilder<T> = Widget Function(
  ChoiceController<T> state,
  VoidCallback openModal,
);
