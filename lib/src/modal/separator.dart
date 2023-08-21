import 'package:flutter/material.dart';
import 'types.dart';

class ChoiceModalSeparator extends Divider {
  const ChoiceModalSeparator({
    super.key,
    super.color,
    super.endIndent,
    super.height,
    super.indent,
    super.thickness,
  });

  static ChoiceModalStateBuilder<T> createBuilder<T>({
    Key? key,
    Color? color,
    double? endIndent,
    double? height,
    double? indent,
    double? thickness,
  }) {
    return (modal) {
      return ChoiceModalSeparator(
        key: key,
        color: color,
        endIndent: endIndent,
        height: height,
        indent: indent,
        thickness: thickness,
      );
    };
  }
}
