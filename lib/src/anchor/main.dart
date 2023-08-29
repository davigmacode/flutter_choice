import 'package:flutter/material.dart';
import 'value.dart';
import 'types.dart';

class ChoiceAnchor extends ListTile {
  const ChoiceAnchor({
    super.key,
    super.title,
    super.subtitle,
    super.leading,
    super.trailing,
    super.dense,
    super.onTap,
  });

  static ChoiceAnchorBuilder<T> create<T>({
    Widget? title,
    Widget? leading,
    Widget? trailing,
    bool? loading,
    bool? inline,
    bool? dense,
    int? valueTruncate,
  }) {
    return (state, openModal) {
      final value = ChoiceValueText(
        value: state.value,
        placeholder: state.multiple ? 'Select one or more' : 'Select',
        truncate: valueTruncate ?? (inline == true ? 1 : 2),
      );
      final effectiveTrailingIcon = loading != true
          ? trailing ?? defaultTrailingIcon
          : defaultTrailingSpinner;
      final effectiveTrailing = inline == true
          ? Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                value,
                effectiveTrailingIcon,
              ],
            )
          : effectiveTrailingIcon;
      return ChoiceAnchor(
        title: title ?? (state.title != null ? Text(state.title!) : null),
        subtitle: inline == true ? null : value,
        leading: leading,
        trailing: effectiveTrailing,
        dense: dense,
        onTap: loading != true ? openModal : null,
      );
    };
  }

  /// Returns default trailing widget
  static const Widget defaultTrailingIcon = Padding(
    padding: EdgeInsets.only(top: 1),
    child: Icon(
      Icons.keyboard_arrow_right,
      color: Colors.grey,
    ),
  );

  /// Returns default loading indicator widget
  static const Widget defaultTrailingSpinner = Padding(
    padding: EdgeInsets.only(left: 8, top: 2),
    child: SizedBox(
      height: 16.0,
      width: 16.0,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
      ),
    ),
  );
}
