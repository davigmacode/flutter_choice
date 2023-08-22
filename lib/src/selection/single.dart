import 'package:flutter/foundation.dart';

abstract class ChoiceSingle {
  static List<T> value<T>(T? value) {
    return [value].whereType<T>().toList();
  }

  static ValueChanged<List<T>> onChanged<T>(ValueChanged<T?>? onChanged) {
    return (List<T> values) {
      onChanged?.call(values.elementAtOrNull(0));
    };
  }
}
