import 'package:flutter/material.dart';
import 'package:choice/selection.dart';
import 'provider.dart';
import 'types.dart';

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

  final ChoiceModalStateBuilder<T> bodyBuilder;
  final ChoiceModalStateBuilder<T>? headerBuilder;
  final ChoiceModalStateBuilder<T>? footerBuilder;
  final ChoiceModalStateBuilder<T>? separatorBuilder;
  final Future<bool> Function()? onWillClose;
  final FlexFit fit;

  static ChoiceModalStateBuilder<T> createBuilder<T>({
    required Widget child,
  }) {
    return (selection, modal) => child;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillClose,
      child: ChoiceSelectionConsumer<T>(builder: (selection, _) {
        return ChoiceModalConsumer<T>(builder: (modal, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              headerBuilder?.call(selection, modal),
              if (headerBuilder != null)
                separatorBuilder?.call(selection, modal),
              Flexible(fit: fit, child: bodyBuilder(selection, modal)),
              if (footerBuilder != null)
                separatorBuilder?.call(selection, modal),
              footerBuilder?.call(selection, modal),
            ].whereType<Widget>().toList(),
          );
        });
      }),
    );
  }
}
