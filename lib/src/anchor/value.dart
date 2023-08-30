import 'package:flutter/material.dart';
import 'package:choice/inline.dart';

class ChoiceValueText<T> extends StatelessWidget {
  const ChoiceValueText({
    super.key,
    required this.value,
    this.placeholder = 'Select one or more',
    this.truncate,
  });

  final List<T> value;
  final String placeholder;
  final int? truncate;

  @override
  Widget build(BuildContext context) {
    final display = truncate ?? value.length;
    final stringify = value.isNotEmpty
        ? value.length > display
            ? display > 0
                ? '${value.take(display).join(', ')}, and ${value.length - display} more'
                : '${value.length} Selected'
            : value.join(', ')
        : placeholder;
    return Text(stringify);
  }
}

class ChoiceValueChips<T> extends StatelessWidget {
  const ChoiceValueChips({
    super.key,
    required this.value,
    this.onDelete,
    this.placeholder = 'Select one or more',
    this.builder,
    this.itemBuilder,
  });

  final List<T> value;
  final ValueSetter<T>? onDelete;
  final String placeholder;
  final ChoiceListBuilder? builder;
  final Widget Function(T value)? itemBuilder;

  static final defaultBuilder = ChoiceList.createWrapped();

  ChoiceListBuilder get effectiveBuilder => builder ?? defaultBuilder;

  int get itemCount => value.length;

  Widget defaultItemBuilder(T singleValue) {
    return InputChip(
      label: Text(singleValue.toString()),
      onDeleted: () {
        onDelete?.call(singleValue);
      },
    );
  }

  Widget effectiveItemBuilder(i) {
    return (itemBuilder ?? defaultItemBuilder).call(value[i]);
  }

  @override
  Widget build(BuildContext context) {
    return itemCount > 0
        ? effectiveBuilder(effectiveItemBuilder, itemCount)
        : Text(placeholder);
  }
}
