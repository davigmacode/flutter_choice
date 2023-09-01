import 'package:flutter/material.dart';
import 'package:choice/selection.dart';

class ChoiceSearchField extends StatelessWidget {
  const ChoiceSearchField({
    super.key,
    this.focusNode,
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
  final FocusNode? focusNode;
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
    FocusNode searchFocusNode = FocusNode();
    return (state) {
      return ChoiceSearchField(
        key: key,
        focusNode: searchFocusNode,
        controller: controller,
        cursorColor: cursorColor,
        textStyle: textStyle,
        hintText: hintText ?? 'Search on ${state.title}',
        hintStyle: hintStyle,
        textAlign: textAlign,
        onSubmitted: !autoSubmit
            ? (query) {
                state.search?.apply(query);
                searchFocusNode.requestFocus();
              }
            : null,
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
      focusNode: focusNode,
      controller: controller,
      style: textStyle,
      cursorColor: cursorColor,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ?? textStyle,
        border: InputBorder.none,
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
    return AnimatedCrossFade(
      crossFadeState: searching == true
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: IconButton(
        icon: iconShow ?? defaultIconShow,
        onPressed: onShow,
      ),
      secondChild: IconButton(
        icon: iconHide ?? defaultIconHide,
        onPressed: onHide,
      ),
      duration: const Duration(milliseconds: 150),
    );
  }
}
