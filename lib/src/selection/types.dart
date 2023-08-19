import 'package:flutter/widgets.dart';
import 'controller.dart';

typedef ChoiceBuilder<T> = Widget Function(
  ChoiceController<T> state,
  Widget? child,
);
