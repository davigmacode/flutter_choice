import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';

class ChoiceModalFooter extends StatelessWidget {
  const ChoiceModalFooter({
    super.key,
    this.color,
    this.padding,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.end,
    required this.children,
  });

  final Color? color;
  final EdgeInsetsGeometry? padding;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final List<Widget> children;

  static ChoiceStateBuilder<T> createBuilder<T>({
    Key? key,
    Color? color,
    EdgeInsetsGeometry? padding,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.end,
    required List<ChoiceStateBuilder> children,
  }) {
    return (state) {
      return ChoiceModalFooter(
        key: key,
        color: color,
        padding: padding,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: children.map((builder) => builder(state)).toList(),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: padding,
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: children,
      ),
    );
  }
}
