import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';
import 'package:choice/modal.dart';
import 'delegate.dart';
import 'trigger.dart';
import 'types.dart';

class PromptedChoice<T> extends ChoiceModal<T> {
  PromptedChoice({
    super.key,
    this.title,
    this.multiple = false,
    this.mandatory = false,
    this.value = const [],
    this.onChanged,
    required super.itemCount,
    required super.itemBuilder,
    super.listBuilder,
    super.dividerBuilder,
    super.leadingBuilder,
    super.trailingBuilder,
    ChoiceModalStateBuilder<T>? modalHeaderBuilder,
    ChoiceModalStateBuilder<T>? modalFooterBuilder,
    ChoiceModalStateBuilder<T>? modalSeparatorBuilder,
    FlexFit modalFit = FlexFit.loose,
    this.triggerBuilder,
    this.promptDelegate,
  }) : super(
          headerBuilder: modalHeaderBuilder,
          footerBuilder: modalFooterBuilder,
          separatorBuilder: modalSeparatorBuilder,
          fit: modalFit,
        );

  final String? title;
  final bool multiple;
  final bool mandatory;
  final List<T> value;
  final ValueChanged<List<T>>? onChanged;
  final ChoicePromptDelegate<T>? promptDelegate;
  final ChoicePromptBuilder<T>? triggerBuilder;

  @override
  Widget build(BuildContext context) {
    return ChoiceSelection(
      title: title,
      multiple: multiple,
      mandatory: mandatory,
      value: value,
      onChanged: onChanged,
      child: ChoicePrompt<T>(
        modal: super.build(context),
        delegate: promptDelegate,
        builder: triggerBuilder ?? ChoiceTrigger.createBuilder(),
      ),
    );
  }
}
