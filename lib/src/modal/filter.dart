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
    bool autoApply = true,
    Duration? delayApply,
  }) {
    return (state) {
      return ChoiceFilter(
        key: key,
        controller: state.filter.ctrl,
        cursorColor: cursorColor,
        textStyle: textStyle,
        hintText: hintText ?? 'Search on ${state.title}',
        hintStyle: hintStyle,
        textAlign: textAlign,
        onSubmitted: autoApply ? null : state.filter.apply,
        onChanged: autoApply
            ? (query) => state.filter.applyDelayed(query, delayApply)
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
    return (state) {
      return Builder(builder: (context) {
        return ChoiceFilterToggle(
          key: key,
          filtering: state.filter.displayed,
          onShow: () => state.filter.show(context),
          onHide: () => state.filter.hide(context),
          iconShow: iconShow,
          iconHide: iconHide,
        );
      });
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
