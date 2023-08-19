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
    ChoiceListBuilder? listBuilder,
    super.dividerBuilder,
    super.leadingBuilder,
    super.trailingBuilder,
  }) : super(builder: listBuilder);

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
      child: super.build(context),
    );
  }
}
