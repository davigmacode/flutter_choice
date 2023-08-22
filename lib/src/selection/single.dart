import 'package:flutter/foundation.dart';

abstract class ChoiceSingle {
  /// Adapter for assign single choice value
  static List<T> value<T>(T? value) {
    return [value].whereType<T>().toList();
  }

  /// Adapter for assign single choice on changed callback
  static ValueChanged<List<T>> onChanged<T>(ValueChanged<T?>? onChanged) {
    return (List<T> values) {
      onChanged?.call(values.elementAtOrNull(0));
    };
  }
}
