import 'package:flutter/material.dart';
import 'types.dart';

class ChoiceConfirmButton extends StatelessWidget {
  const ChoiceConfirmButton({
    super.key,
    this.icon,
    this.label,
    this.color,
    this.margin,
    this.brightness = Brightness.light,
    this.onPressed,
  });

  final Widget? icon;
  final Widget? label;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final Brightness brightness;
  final VoidCallback? onPressed;

  /// Returns true if the confirm button brightness is dark
  bool get isDark => brightness == Brightness.dark;

  /// Returns true if the confirm button brightness is light
  bool get isLight => brightness == Brightness.light;

  static ChoiceModalStateBuilder<T> createBuilder<T>({
    Key? key,
    Widget? icon,
    Widget? label,
    Color? color,
    EdgeInsetsGeometry? margin,
    Brightness brightness = Brightness.light,
  }) {
    return (selection, modal) {
      return ChoiceConfirmButton(
        key: key,
        icon: icon,
        label: label,
        color: color,
        margin: margin,
        brightness: brightness,
        onPressed: () {
          modal.close(confirmed: true);
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      if (icon != null) {
        return Center(
          child: Padding(
            padding: margin ?? const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: TextButton.icon(
              icon: icon!,
              label: label!,
              style: TextButton.styleFrom(
                backgroundColor: isDark ? color : null,
                foregroundColor: isLight ? color : Colors.white,
              ),
              onPressed: onPressed,
            ),
          ),
        );
      } else {
        return Center(
          child: Padding(
            padding: margin ?? const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: isDark ? color ?? Colors.blueGrey : null,
                foregroundColor: isLight ? color : Colors.white,
              ),
              onPressed: onPressed,
              child: label!,
            ),
          ),
        );
      }
    } else {
      return Padding(
        padding: margin ?? const EdgeInsets.all(0),
        child: IconButton(
          icon: icon ?? const Icon(Icons.check_circle_outline),
          color: color,
          onPressed: onPressed,
        ),
      );
    }
  }
}
