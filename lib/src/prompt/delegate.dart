import 'package:flutter/material.dart';
import 'types.dart';

abstract class ChoicePrompt {
  static ChoicePromptDelegate<T> delegateNewPage<T>({
    Color? backgroundColor,
    Widget? header,
  }) {
    return (context, modal) {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: backgroundColor,
            appBar: header != null
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: header,
                  )
                : null,
            body: SafeArea(
              maintainBottomViewPadding: true,
              child: modal,
            ),
          ),
        ),
      );
    };
  }

  static ChoicePromptDelegate<T> delegatePopupDialog<T>({
    bool useSafeArea = true,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    Color? backgroundColor,
    double? elevation,
    Color? shadowColor,
    Color? surfaceTintColor,
    Clip clipBehavior = Clip.antiAlias,
    ShapeBorder? shape,
    BoxConstraints? constraints,
    double? maxWidthFactor,
    double? maxHeightFactor,
  }) {
    return (context, modal) {
      return showDialog(
        context: context,
        useSafeArea: useSafeArea,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        builder: (_) => FractionallySizedBox(
          widthFactor: maxWidthFactor,
          heightFactor: maxHeightFactor,
          child: Dialog(
            shape: shape,
            clipBehavior: clipBehavior,
            backgroundColor: backgroundColor,
            surfaceTintColor: surfaceTintColor,
            shadowColor: shadowColor,
            elevation: elevation,
            child: Container(
              constraints: constraints,
              child: modal,
            ),
          ),
        ),
      );
    };
  }

  static ChoicePromptDelegate<T> delegateBottomSheet<T>({
    bool useSafeArea = true,
    bool enableDrag = true,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    Color? backgroundColor,
    double? elevation,
    Clip clipBehavior = Clip.antiAlias,
    ShapeBorder? shape,
    double maxHeightFactor = 0.6,
  }) {
    return (context, modal) {
      return showModalBottomSheet(
        context: context,
        shape: shape,
        clipBehavior: clipBehavior,
        backgroundColor: backgroundColor,
        elevation: elevation,
        useSafeArea: useSafeArea,
        isDismissible: barrierDismissible,
        barrierColor: barrierColor,
        enableDrag: enableDrag,
        isScrollControlled: true,
        builder: (_) {
          final MediaQueryData mq = MediaQueryData.fromView(View.of(context));
          final double topObstructions = mq.viewPadding.top;
          final double bottomObstructions = mq.viewPadding.bottom;
          final double keyboardHeight = mq.viewInsets.bottom;
          final double deviceHeight = mq.size.height;
          final bool isKeyboardOpen = keyboardHeight > 0;
          final double heightFactor = isKeyboardOpen ? 1 : maxHeightFactor;
          final double modalHeight =
              (deviceHeight * heightFactor) + keyboardHeight;
          final bool isFullHeight = modalHeight >= deviceHeight;
          return Container(
            padding: EdgeInsets.only(
              top: isFullHeight ? topObstructions : 0,
              bottom: keyboardHeight + bottomObstructions,
            ),
            constraints: BoxConstraints(
              maxHeight: isFullHeight ? double.infinity : modalHeight,
            ),
            child: modal,
          );
        },
      );
    };
  }
}
