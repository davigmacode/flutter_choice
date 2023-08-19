import 'package:flutter/material.dart';
import 'package:choice/inline.dart';
import 'provider.dart';
import 'types.dart';

class ChoiceModal<T> extends ChoiceList<T> {
  ChoiceModal({
    super.key,
    this.headerBuilder,
    this.footerBuilder,
    this.separatorBuilder,
    this.onWillClose,
    this.fit = FlexFit.loose,
    required super.itemCount,
    required super.itemBuilder,
    ChoiceListBuilder? listBuilder,
    super.dividerBuilder,
    super.leadingBuilder,
    super.trailingBuilder,
  }) : super(builder: listBuilder ?? ChoiceList.virtualized());

  final ChoiceModalStateBuilder<T>? headerBuilder;
  final ChoiceModalStateBuilder<T>? footerBuilder;
  final ChoiceModalStateBuilder<T>? separatorBuilder;
  final Future<bool> Function()? onWillClose;
  final FlexFit fit;

  static ChoiceModalStateBuilder<T> createBuilder<T>({
    required Widget child,
  }) {
    return (state) => child;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillClose,
      child: ChoiceModalConsumer<T>(builder: (state, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            headerBuilder?.call(state),
            if (headerBuilder != null) separatorBuilder?.call(state),
            Flexible(fit: fit, child: super.build(context)),
            if (footerBuilder != null) separatorBuilder?.call(state),
            footerBuilder?.call(state),
          ].whereType<Widget>().toList(),
        );
      }),
    );
  }
}
