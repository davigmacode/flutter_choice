import 'package:flutter/material.dart';
import 'package:choice/selection.dart';

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

  final ChoiceStateBuilder<T> bodyBuilder;
  final ChoiceStateBuilder<T>? headerBuilder;
  final ChoiceStateBuilder<T>? footerBuilder;
  final ChoiceStateBuilder<T>? separatorBuilder;
  final Future<bool> Function()? onWillClose;
  final FlexFit fit;

  static ChoiceStateBuilder<T> createBuilder<T>({
    required Widget child,
  }) {
    return (_) => child;
  }

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
