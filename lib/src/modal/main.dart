import 'package:flutter/material.dart';
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
    return (modal) => child;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillClose,
      child: ChoiceModalConsumer<T>(builder: (modal, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            headerBuilder?.call(modal),
            if (headerBuilder != null) separatorBuilder?.call(modal),
            Flexible(fit: fit, child: bodyBuilder(modal)),
            if (footerBuilder != null) separatorBuilder?.call(modal),
            footerBuilder?.call(modal),
          ].whereType<Widget>().toList(),
        );
      }),
    );
  }
}
