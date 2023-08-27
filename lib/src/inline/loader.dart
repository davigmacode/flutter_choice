import 'package:flutter/material.dart';
import 'package:choice/selection.dart';

class ChoiceListLoader extends StatelessWidget {
  const ChoiceListLoader({
    super.key,
    this.padding,
    this.constraints,
    this.size,
    required this.child,
  });

  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final double? size;
  final Widget child;

  static ChoiceStateBuilder<T> createCircularLoader<T>({
    Key? key,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints = const BoxConstraints(minHeight: 200),
    double size = 16,
    double thickness = 2,
  }) {
    return (state) {
      return ChoiceListLoader(
        key: key,
        padding: padding,
        constraints: constraints,
        size: size,
        child: CircularProgressIndicator(
          strokeWidth: thickness,
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
        child: SizedBox(
          width: size,
          height: size,
          child: child,
        ),
      ),
    );
  }
}
