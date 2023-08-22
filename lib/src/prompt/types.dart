import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';

typedef ChoicePromptDelegate<T> = Future<List<T>?> Function(
  BuildContext context,
  Widget modal,
);

typedef ChoicePromptBuilder<T> = Widget Function(
  ChoiceController<T> state,
  VoidCallback openModal,
);
