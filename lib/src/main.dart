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
    this.confirmation = false,
    this.value = const [],
    this.onChanged,
    required ChoiceSelectionBuilder<T> builder,
    Widget? child,
  }) : child = ChoiceSelection.builder(
          title: title,
          multiple: multiple,
          mandatory: mandatory,
          confirmation: confirmation,
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
    ChoiceSkipCallback itemSkip = ChoiceList.defaultItemSkip,
    ChoiceStateBuilder<T>? dividerBuilder,
    ChoiceStateBuilder<T>? leadingBuilder,
    ChoiceStateBuilder<T>? trailingBuilder,
    ChoiceListBuilder? listBuilder,
  })  : confirmation = false,
        child = InlineChoice(
          title: title,
          multiple: multiple,
          mandatory: mandatory,
          value: value,
          onChanged: onChanged,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          itemSkip: itemSkip,
          dividerBuilder: dividerBuilder,
          leadingBuilder: leadingBuilder,
          trailingBuilder: trailingBuilder,
          listBuilder: listBuilder,
        );

  Choice.prompt({
    super.key,
    this.title,
    this.multiple = false,
    this.mandatory = false,
    this.confirmation = false,
    this.value = const [],
    this.onChanged,
    required int itemCount,
    required IndexedChoiceModalStateBuilder<T> itemBuilder,
    ChoiceSkipCallback itemSkip = ChoiceList.defaultItemSkip,
    ChoiceModalStateBuilder<T>? dividerBuilder,
    ChoiceModalStateBuilder<T>? leadingBuilder,
    ChoiceModalStateBuilder<T>? trailingBuilder,
    ChoiceListBuilder? listBuilder,
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
          confirmation: confirmation,
          value: value,
          onChanged: onChanged,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          itemSkip: itemSkip,
          dividerBuilder: dividerBuilder,
          leadingBuilder: leadingBuilder,
          trailingBuilder: trailingBuilder,
          listBuilder: listBuilder,
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
  final bool confirmation;
  final List<T> value;
  final ValueChanged<List<T>>? onChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
