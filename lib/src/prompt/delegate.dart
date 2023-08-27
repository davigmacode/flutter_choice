import 'package:flutter/material.dart';
import 'package:choice/selection.dart';
import 'package:choice/utils.dart';
import 'types.dart';

class ChoicePrompt<T> extends StatefulWidget {
  ChoicePrompt({
    super.key,
    required this.builder,
    required this.modal,
    ChoicePromptDelegate<T>? delegate,
    this.searchable = false,
    this.onSearch,
  }) : delegate = delegate ?? delegatePopupDialog();

  final ChoicePromptBuilder<T> builder;
  final Widget modal;
  final ChoicePromptDelegate<T> delegate;
  final bool searchable;
  final ValueSetter<String>? onSearch;

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

  @override
  State<ChoicePrompt<T>> createState() => _ChoicePromptState<T>();
}

class _ChoicePromptState<T> extends State<ChoicePrompt<T>> {
  // ChoiceController<T>? _state;

  StateSetter? _rerenderModal;

  ChoiceSearchController createSearchController(BuildContext context) {
    return ChoiceSearchController(
      onAttach: (state) {
        // add history to route, so back button will appear
        // and when physical back button pressed
        // will close the search bar instead of close the modal
        LocalHistoryEntry entry = LocalHistoryEntry(
          onRemove: state.deactivate,
        );
        ModalRoute.of(context)?.addLocalHistoryEntry(entry);
      },
      onDetach: (state) {
        // remove search from route history
        Navigator.pop(context);
      },
      onChanged: widget.onSearch,
    );
  }

  VoidCallback createOpenModal(
    BuildContext context,
    ChoiceController<T> state,
  ) {
    return () async {
      final res = await widget.delegate(
        context,
        wrapModalWithNewController(state),
      );
      if (res != null) {
        state.replace(res);
      }
    };
  }

  Widget wrapModalWithNewController(ChoiceController<T> state) {
    return Builder(
      builder: (modalContext) {
        return ChoiceProvider<T>(
          controller: state.copyWith(
            search:
                widget.searchable ? createSearchController(modalContext) : null,
            onCloseModal: (value) {
              Navigator.maybePop(modalContext, value);
            },
            onChanged: (value) {
              if (!state.confirmation) {
                state.replace(value);
              }
            },
          ),
          child: SafeStatefulBuilder(builder: (context, setModalState) {
            _rerenderModal = setModalState;
            return widget.modal;
          }),
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant ChoicePrompt<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.modal != oldWidget.modal) {
      Future.delayed(Duration.zero, () async {
        _rerenderModal?.call(() {});
      });
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _state = ChoiceProvider.of<T>(context);
  // }

  @override
  Widget build(BuildContext context) {
    return ChoiceConsumer<T>(
      builder: (state, _) {
        // _state = state;
        return widget.builder(state, createOpenModal(context, state));
      },
    );
  }
}
