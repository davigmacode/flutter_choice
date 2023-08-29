import 'package:flutter/material.dart';
import 'package:choice/selection.dart';

/// Placeholder widget for empty choice items
class ChoiceListPlaceholder extends StatelessWidget {
  const ChoiceListPlaceholder({
    super.key,
    this.padding,
    this.constraints,
    this.spacing,
    required this.icon,
    required this.text,
  });

  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final double? spacing;
  final Widget icon;
  final Widget text;

  static ChoiceStateBuilder<T> create<T>({
    Key? key,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints,
    double spacing = 16,
    Widget icon = const Icon(
      Icons.search,
      color: Colors.grey,
      size: 120.0,
    ),
    Widget text = const Text(
      'Whoops, no matches',
      style: TextStyle(color: Colors.grey),
    ),
  }) {
    return (state) {
      return ChoiceListPlaceholder(
        key: key,
        padding: padding,
        constraints: constraints,
        spacing: spacing,
        icon: icon,
        text: text,
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      constraints: constraints,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            SizedBox(height: spacing),
            text,
          ],
        ),
      ),
    );
  }
}
