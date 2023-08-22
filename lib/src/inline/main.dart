import 'package:choice/selection.dart';
import 'package:flutter/widgets.dart';
import 'list.dart';
import 'types.dart';

class InlineChoice<T> extends ChoiceList<T> {
  const InlineChoice({
    super.key,
    this.title,
    this.multiple = false,
    this.mandatory = false,
    this.value = const [],
    this.onChanged,
    required super.itemCount,
    required super.itemBuilder,
    super.itemSkip,
    super.dividerBuilder,
    super.leadingBuilder,
    super.trailingBuilder,
    ChoiceListBuilder? listBuilder,
  }) : super(builder: listBuilder);

  InlineChoice.single({
    super.key,
    this.title,
    this.mandatory = false,
    T? value,
    ValueChanged<T?>? onChanged,
    required super.itemCount,
    required super.itemBuilder,
    super.itemSkip,
    super.dividerBuilder,
    super.leadingBuilder,
    super.trailingBuilder,
    ChoiceListBuilder? listBuilder,
  })  : multiple = false,
        value = ChoiceSingle.value(value),
        onChanged = ChoiceSingle.onChanged(onChanged);

  const InlineChoice.multiple({
    super.key,
    this.title,
    this.mandatory = false,
    this.value = const [],
    this.onChanged,
    required super.itemCount,
    required super.itemBuilder,
    super.itemSkip,
    super.dividerBuilder,
    super.leadingBuilder,
    super.trailingBuilder,
    ChoiceListBuilder? listBuilder,
  }) : multiple = true;

  final String? title;
  final bool multiple;
  final bool mandatory;
  final List<T> value;
  final ValueChanged<List<T>>? onChanged;

  @override
  Widget build(BuildContext context) {
    return ChoiceSelection(
      title: title,
      multiple: multiple,
      mandatory: mandatory,
      value: value,
      onChanged: onChanged,
      child: Builder(
        builder: (innerContext) => super.build(innerContext),
      ),
    );
  }
}
