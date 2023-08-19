import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';
import 'package:choice/inline.dart';
import 'package:choice/prompt.dart';
import 'package:choice/modal.dart';

class Choice<T> extends StatelessWidget {
  Choice({
    super.key,
    this.title,
    this.multiple = false,
    this.mandatory = false,
    this.value = const [],
    this.onChanged,
    required ChoiceSelectionBuilder<T> builder,
    Widget? child,
  }) : child = ChoiceSelection.builder(
          title: title,
          multiple: multiple,
          mandatory: mandatory,
          value: value,
          onChanged: onChanged,
          builder: builder,
          child: child,
        );

  Choice.inline({
    super.key,
    this.title,
    this.multiple = false,
    this.mandatory = false,
    this.value = const [],
    this.onChanged,
    required int itemCount,
    required IndexedChoiceStateBuilder<T> itemBuilder,
    ChoiceListBuilder? listBuilder,
    ChoiceStateBuilder<T>? dividerBuilder,
    ChoiceStateBuilder<T>? leadingBuilder,
    ChoiceStateBuilder<T>? trailingBuilder,
  }) : child = InlineChoice(
          title: title,
          multiple: multiple,
          mandatory: mandatory,
          value: value,
          onChanged: onChanged,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          listBuilder: listBuilder,
          dividerBuilder: dividerBuilder,
          leadingBuilder: leadingBuilder,
          trailingBuilder: trailingBuilder,
        );

  Choice.prompt({
    super.key,
    this.title,
    this.multiple = false,
    this.mandatory = false,
    this.value = const [],
    this.onChanged,
    required int itemCount,
    required IndexedChoiceStateBuilder<T> itemBuilder,
    ChoiceListBuilder? listBuilder,
    ChoiceStateBuilder<T>? dividerBuilder,
    ChoiceStateBuilder<T>? leadingBuilder,
    ChoiceStateBuilder<T>? trailingBuilder,
    ChoiceModalStateBuilder<T>? modalHeaderBuilder,
    ChoiceModalStateBuilder<T>? modalFooterBuilder,
    ChoiceModalStateBuilder<T>? modalSeparatorBuilder,
    FlexFit modalFit = FlexFit.loose,
    ChoicePromptBuilder<T>? triggerBuilder,
    ChoicePromptDelegate<T>? promptDelegate,
    bool filterable = false,
  }) : child = PromptedChoice(
          title: title,
          multiple: multiple,
          mandatory: mandatory,
          value: value,
          onChanged: onChanged,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          listBuilder: listBuilder,
          dividerBuilder: dividerBuilder,
          leadingBuilder: leadingBuilder,
          trailingBuilder: trailingBuilder,
          modalHeaderBuilder: modalHeaderBuilder,
          modalFooterBuilder: modalFooterBuilder,
          modalSeparatorBuilder: modalSeparatorBuilder,
          modalFit: modalFit,
          triggerBuilder: triggerBuilder,
          promptDelegate: promptDelegate,
          filterable: filterable,
        );

  final String? title;
  final bool multiple;
  final bool mandatory;
  final List<T> value;
  final ValueChanged<List<T>>? onChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
