import 'package:flutter/material.dart';
import 'package:choice/utils.dart';
import 'types.dart';

class ChoiceFilter extends StatelessWidget {
  const ChoiceFilter({
    super.key,
    this.controller,
    this.cursorColor,
    this.textStyle,
    this.hintText,
    this.hintStyle,
    this.textAlign = TextAlign.start,
    this.onSubmitted,
    this.onChanged,
  });

  final TextEditingController? controller;
  final Color? cursorColor;
  final TextStyle? textStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextAlign textAlign;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;

  static bool test(String? value, String? query) {
    return value != null
        ? query != null
            ? normalized(value).contains(normalized(query))
            : true
        : false;
  }

  static ChoiceModalStateBuilder<T> createBuilder<T>({
    Key? key,
    TextEditingController? controller,
    Color? cursorColor,
    TextStyle? textStyle,
    String? hintText,
    TextStyle? hintStyle,
    TextAlign textAlign = TextAlign.start,
    bool autoSubmit = true,
    Duration? submitDelay,
  }) {
    return (selection, modal) {
      return ChoiceFilter(
        key: key,
        controller: modal.filter.controller,
        cursorColor: cursorColor,
        textStyle: textStyle,
        hintText: hintText ?? 'Search on ${modal.title}',
        hintStyle: hintStyle,
        textAlign: textAlign,
        onSubmitted: !autoSubmit ? modal.filter.apply : null,
        onChanged: autoSubmit
            ? (query) => modal.filter.apply(query, submitDelay)
            : null,
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: controller,
      style: textStyle,
      cursorColor: cursorColor,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration.collapsed(
        hintText: hintText,
        hintStyle: hintStyle ?? textStyle,
      ),
      textAlign: textAlign,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
    );
  }
}

class ChoiceFilterToggle extends StatelessWidget {
  const ChoiceFilterToggle({
    super.key,
    required this.filtering,
    required this.onShow,
    required this.onHide,
    this.iconShow,
    this.iconHide,
  });

  final bool filtering;
  final Widget? iconShow;
  final Widget? iconHide;
  final VoidCallback onShow;
  final VoidCallback onHide;

  static const defaultIconShow = Icon(Icons.search);
  static const defaultIconHide = Icon(Icons.clear);

  static ChoiceModalStateBuilder<T> createBuilder<T>({
    Key? key,
    Widget? iconShow,
    Widget? iconHide,
  }) {
    return (selection, modal) {
      return ChoiceFilterToggle(
        key: key,
        filtering: modal.filter.active,
        onShow: () => modal.filter.show(),
        onHide: () => modal.filter.hide(),
        iconShow: iconShow,
        iconHide: iconHide,
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return !filtering
        ? IconButton(
            icon: iconShow ?? defaultIconShow,
            onPressed: onShow,
          )
        : IconButton(
            icon: iconHide ?? defaultIconHide,
            onPressed: onHide,
          );
  }
}
