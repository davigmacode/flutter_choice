import 'package:flutter/material.dart';
import 'package:animated_checkmark/animated_checkmark.dart';

class CustomChoiceItem extends StatelessWidget {
  final String label;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final bool selected;
  final ValueChanged<bool> onSelect;

  const CustomChoiceItem({
    Key? key,
    required this.label,
    this.color,
    this.width,
    this.height,
    this.margin,
    this.selected = false,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      width: width,
      height: height,
      margin: margin,
      duration: const Duration(milliseconds: 200),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: selected
            ? (color ?? Colors.green)
            : theme.unselectedWidgetColor.withOpacity(.12),
        borderRadius: BorderRadius.all(Radius.circular(selected ? 100 : 10)),
        border: Border.all(
          color: selected
              ? (color ?? Colors.green)
              : theme.colorScheme.onSurface.withOpacity(.38),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 10)),
        onTap: () => onSelect(!selected),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: AnimatedCheckmark(
                active: selected,
                color: Colors.white,
                size: const Size.square(32),
                weight: 5,
                duration: const Duration(milliseconds: 200),
              ),
            ),
            Positioned(
              left: 9,
              right: 9,
              bottom: 10,
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selected ? Colors.white : theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
