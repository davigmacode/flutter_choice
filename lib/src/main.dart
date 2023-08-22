import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';
import 'package:choice/inline.dart';
import 'package:choice/prompt.dart';

class Choice<T> extends StatelessWidget {
  Choice({
    super.key,
    this.title,
    this.multiple = false,
    this.clearable = false,
    this.confirmation = false,
    this.value = const [],
    this.onChanged,
    required Widget child,
  }) : child = ChoiceProvider<T>(
          controller: ChoiceController<T>(
            title: title,
            multiple: multiple,
            clearable: clearable,
            confirmation: confirmation,
            value: value,
            onChanged: onChanged,
          ),
          child: child,
        );

  Choice.builder({
    super.key,
    this.title,
    this.multiple = false,
    this.clearable = false,
    this.confirmation = false,
    this.value = const [],
    this.onChanged,
    required ChoiceBuilder<T> builder,
    Widget? child,
  }) : child = ChoiceProvider<T>.builder(
          controller: ChoiceController<T>(
            title: title,
            multiple: multiple,
            clearable: clearable,
            confirmation: confirmation,
            value: value,
            onChanged: onChanged,
          ),
          builder: builder,
          child: child,
        );

  Choice.inline({
    super.key,
    this.title,
    this.multiple = false,
    this.clearable = false,
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
        child = InlineChoice<T>(
          title: title,
          multiple: multiple,
          clearable: clearable,
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
    this.clearable = false,
    this.confirmation = false,
    this.value = const [],
    this.onChanged,
    required int itemCount,
    required IndexedChoiceStateBuilder<T> itemBuilder,
    ChoiceSkipCallback itemSkip = ChoiceList.defaultItemSkip,
    ChoiceStateBuilder<T>? dividerBuilder,
    ChoiceStateBuilder<T>? leadingBuilder,
    ChoiceStateBuilder<T>? trailingBuilder,
    ChoiceListBuilder? listBuilder,
    ChoiceStateBuilder<T>? modalHeaderBuilder,
    ChoiceStateBuilder<T>? modalFooterBuilder,
    ChoiceStateBuilder<T>? modalSeparatorBuilder,
    FlexFit modalFit = FlexFit.loose,
    ChoicePromptBuilder<T>? triggerBuilder,
    ChoicePromptDelegate<T>? promptDelegate,
    bool filterable = false,
  }) : child = PromptedChoice<T>(
          title: title,
          multiple: multiple,
          clearable: clearable,
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
  final bool clearable;
  final bool confirmation;
  final List<T> value;
  final ValueChanged<List<T>>? onChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
