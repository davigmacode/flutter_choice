import 'package:flutter/material.dart';
import 'types.dart';

class ChoiceTrigger extends StatelessWidget {
  const ChoiceTrigger({
    super.key,
    this.title,
    required this.value,
    required this.onTap,
    this.leading,
    this.trailing,
    this.loading,
    this.inline,
    this.dense,
  });

  final VoidCallback onTap;
  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final bool? loading;
  final bool? inline;
  final bool? dense;
  final Widget value;

  static ChoicePromptBuilder<T> createBuilder<T>({
    Widget? title,
    Widget? leading,
    Widget? trailing,
    bool? loading,
    bool? inline,
    bool? dense,
    int? valueTruncate,
  }) {
    return (state, openModal) {
      return ChoiceTrigger(
        title: title ?? (state.title != null ? Text(state.title!) : null),
        value: ChoiceValueDisplay(
          value: state.value,
          placeholder: state.multiple ? 'Select one or more' : 'Select',
          truncate: valueTruncate ?? (inline == true ? 1 : 2),
        ),
        leading: leading,
        trailing: trailing,
        loading: loading,
        inline: inline,
        onTap: openModal,
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

  Widget get _trailing {
    return inline == true
        ? Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              value,
              _trailingIcon,
            ],
          )
        : _trailingIcon;
  }

  Widget get _trailingIcon {
    return loading != true
        ? trailing ?? defaultTrailingIcon
        : defaultTrailingSpinner;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      leading: leading,
      subtitle: inline == true ? null : value,
      trailing: _trailing,
      dense: dense,
      onTap: loading != true ? onTap : null,
    );
  }
}

class ChoiceValueDisplay<T> extends StatelessWidget {
  const ChoiceValueDisplay({
    super.key,
    required this.value,
    this.placeholder = 'Select one or more',
    this.truncate,
  });

  final List<T> value;
  final String placeholder;
  final int? truncate;

  @override
  Widget build(BuildContext context) {
    final display = truncate ?? value.length;
    final stringify = value.isNotEmpty
        ? value.length > display
            ? display > 0
                ? '${value.take(display).join(', ')}, and ${value.length - display} more'
                : '${value.length} Selected'
            : value.join(', ')
        : placeholder;
    return Text(stringify);
  }
}
