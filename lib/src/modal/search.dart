import 'package:flutter/material.dart';
import 'package:choice/selection.dart';

class ChoiceSearchField extends StatelessWidget {
  const ChoiceSearchField({
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

  static ChoiceStateBuilder<T> create<T>({
    Key? key,
    TextEditingController? controller,
    Color? cursorColor,
    TextStyle? textStyle,
    String? hintText,
    TextStyle? hintStyle,
    TextAlign textAlign = TextAlign.start,
    bool autoSubmit = false,
    Duration? submitDelay,
  }) {
    return (state) {
      return ChoiceSearchField(
        key: key,
        controller: controller,
        cursorColor: cursorColor,
        textStyle: textStyle,
        hintText: hintText ?? 'Search on ${state.title}',
        hintStyle: hintStyle,
        textAlign: textAlign,
        onSubmitted: !autoSubmit ? state.search?.apply : null,
        onChanged: autoSubmit
            ? (query) => state.search?.apply(query, submitDelay)
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

class ChoiceSearchToggle extends StatelessWidget {
  const ChoiceSearchToggle({
    super.key,
    this.searching,
    this.onShow,
    this.onHide,
    this.iconShow,
    this.iconHide,
  });

  final bool? searching;
  final Widget? iconShow;
  final Widget? iconHide;
  final VoidCallback? onShow;
  final VoidCallback? onHide;

  static const defaultIconShow = Icon(Icons.search);
  static const defaultIconHide = Icon(Icons.clear);

  static ChoiceStateBuilder<T> create<T>({
    Key? key,
    Widget? iconShow,
    Widget? iconHide,
  }) {
    return (modal) {
      return ChoiceSearchToggle(
        key: key,
        searching: modal.search?.active ?? false,
        onShow: modal.search?.attach,
        onHide: modal.search?.detach,
        iconShow: iconShow,
        iconHide: iconHide,
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return searching != true
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
