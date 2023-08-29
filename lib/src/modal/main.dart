import 'package:flutter/material.dart';
import 'package:choice/selection.dart';
import 'header.dart';
import 'search.dart';
import 'footer.dart';
import 'separator.dart';
import 'button.dart';

class ChoiceModal<T> extends StatelessWidget {
  const ChoiceModal({
    super.key,
    required this.bodyBuilder,
    this.headerBuilder,
    this.footerBuilder,
    this.separatorBuilder,
    this.onWillClose,
    this.fit = FlexFit.loose,
  });

  /// {@template choice.modal.bodyBuilder}
  /// Called to build modal body widget
  /// {@endtemplate}
  final ChoiceStateBuilder<T> bodyBuilder;

  /// {@template choice.modal.headerBuilder}
  /// Called to build modal header widget
  /// {@endtemplate}
  final ChoiceStateBuilder<T>? headerBuilder;

  /// {@template choice.modal.footerBuilder}
  /// Called to build modal footer widget
  /// {@endtemplate}
  final ChoiceStateBuilder<T>? footerBuilder;

  /// {@template choice.modal.separatorBuilder}
  /// Called to build modal separator widget
  /// {@endtemplate}
  final ChoiceStateBuilder<T>? separatorBuilder;

  /// {@template choice.modal.onWillClose}
  /// Called to veto attempts by the user to dismiss the enclosing [ModalRoute].
  ///
  /// If the callback returns a Future that resolves to false, the enclosing route will not be popped.
  /// {@endtemplate}
  final Future<bool> Function()? onWillClose;

  /// {@template choice.modal.fit}
  /// How a flexible modal body is inscribed into the available space.
  ///
  /// If [flex] is non-zero, the [fit] determines whether
  /// the modal body fills the space the parent makes available during layout.
  /// If the fit is [FlexFit.tight], the modal body is required to fill the available space.
  /// If the fit is [FlexFit.loose], the modal body can be at most as large as the available space
  /// (but is allowed to be smaller).
  /// {@endtemplate}
  final FlexFit fit;

  static ChoiceStateBuilder<T> createWidget<T>({
    required Widget child,
  }) {
    return (_) => child;
  }

  static const createHeader = ChoiceModalHeader.create;

  static const createSearchField = ChoiceSearchField.create;

  static const createSearchToggle = ChoiceSearchToggle.create;

  static const createFooter = ChoiceModalFooter.create;

  static const createSeparator = ChoiceModalSeparator.create;

  static const createConfirmButton = ChoiceConfirmButton.create;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillClose,
      child: ChoiceConsumer<T>(builder: (state, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            headerBuilder?.call(state),
            if (headerBuilder != null) separatorBuilder?.call(state),
            Flexible(fit: fit, child: bodyBuilder(state)),
            if (footerBuilder != null) separatorBuilder?.call(state),
            footerBuilder?.call(state),
          ].whereType<Widget>().toList(),
        );
      }),
    );
  }
}
