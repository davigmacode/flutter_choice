import 'package:flutter/material.dart';
import 'package:choice/selection.dart';

class ChoiceListError extends StatelessWidget {
  const ChoiceListError({
    super.key,
    this.padding,
    this.constraints,
    required this.child,
  });

  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final Widget child;

  static ChoiceStateBuilder<T> create<T>({
    Key? key,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints,
    Color? color = Colors.red,
    TextAlign? textAlign = TextAlign.center,
    required String message,
  }) {
    return (state) {
      return ChoiceListError(
        key: key,
        padding: padding,
        constraints: constraints,
        child: Text(
          message,
          textAlign: textAlign,
          style: TextStyle(color: color),
        ),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      constraints: constraints,
      child: Center(
        child: child,
      ),
    );
  }
}
