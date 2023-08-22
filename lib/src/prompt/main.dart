import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';
import 'package:choice/inline.dart';
import 'package:choice/modal.dart';
import 'delegate.dart';
import 'trigger.dart';
import 'types.dart';

class PromptedChoice<T> extends StatelessWidget {
  const PromptedChoice({
    super.key,
    this.title,
    this.multiple = false,
    this.clearable = false,
    this.confirmation = false,
    this.value = const [],
    this.onChanged,
    required this.itemCount,
    required this.itemBuilder,
    this.itemSkip,
    this.dividerBuilder,
    this.leadingBuilder,
    this.trailingBuilder,
    this.listBuilder,
    this.modalHeaderBuilder,
    this.modalFooterBuilder,
    this.modalSeparatorBuilder,
    this.modalFit = FlexFit.loose,
    this.triggerBuilder,
    this.promptDelegate,
    this.filterable = false,
  });

  PromptedChoice.single({
    super.key,
    this.title,
    this.clearable = false,
    this.confirmation = false,
    T? value,
    ValueChanged<T?>? onChanged,
    required this.itemCount,
    required this.itemBuilder,
    this.itemSkip,
    this.dividerBuilder,
    this.leadingBuilder,
    this.trailingBuilder,
    this.listBuilder,
    this.modalHeaderBuilder,
    this.modalFooterBuilder,
    this.modalSeparatorBuilder,
    this.modalFit = FlexFit.loose,
    this.triggerBuilder,
    this.promptDelegate,
    this.filterable = false,
  })  : multiple = false,
        value = ChoiceSingle.value(value),
        onChanged = ChoiceSingle.onChanged(onChanged);

  const PromptedChoice.multiple({
    super.key,
    this.title,
    this.clearable = false,
    this.confirmation = false,
    this.value = const [],
    this.onChanged,
    required this.itemCount,
    required this.itemBuilder,
    this.itemSkip,
    this.dividerBuilder,
    this.leadingBuilder,
    this.trailingBuilder,
    this.listBuilder,
    this.modalHeaderBuilder,
    this.modalFooterBuilder,
    this.modalSeparatorBuilder,
    this.modalFit = FlexFit.loose,
    this.triggerBuilder,
    this.promptDelegate,
    this.filterable = false,
  }) : multiple = true;

  final String? title;
  final bool multiple;
  final bool clearable;
  final bool confirmation;
  final List<T> value;
  final ValueChanged<List<T>>? onChanged;
  final int itemCount;
  final IndexedChoiceStateBuilder<T> itemBuilder;
  final ChoiceSkipCallback? itemSkip;
  final ChoiceStateBuilder<T>? dividerBuilder;
  final ChoiceStateBuilder<T>? leadingBuilder;
  final ChoiceStateBuilder<T>? trailingBuilder;
  final ChoiceListBuilder? listBuilder;
  final ChoiceStateBuilder<T>? modalHeaderBuilder;
  final ChoiceStateBuilder<T>? modalFooterBuilder;
  final ChoiceStateBuilder<T>? modalSeparatorBuilder;
  final FlexFit modalFit;
  final ChoicePromptDelegate<T>? promptDelegate;
  final ChoicePromptBuilder<T>? triggerBuilder;
  final bool filterable;

  @override
  Widget build(BuildContext context) {
    return ChoiceProvider<T>(
      controller: ChoiceController<T>(
        title: title,
        multiple: multiple,
        clearable: clearable,
        confirmation: confirmation,
        value: value,
        onChanged: onChanged,
      ),
      child: ChoicePrompt<T>(
        filterable: filterable,
        delegate: promptDelegate,
        builder: triggerBuilder ?? ChoiceTrigger.createBuilder(),
        modal: ChoiceModal<T>(
          fit: modalFit,
          headerBuilder: modalHeaderBuilder,
          footerBuilder: modalFooterBuilder,
          separatorBuilder: modalSeparatorBuilder,
          bodyBuilder: (modal) {
            return ChoiceList<T>(
              keyword: modal.filter?.value,
              itemSkip: itemSkip,
              itemCount: itemCount,
              itemBuilder: (_, i) => itemBuilder(modal, i),
              dividerBuilder:
                  dividerBuilder != null ? (_) => dividerBuilder!(modal) : null,
              leadingBuilder:
                  leadingBuilder != null ? (_) => leadingBuilder!(modal) : null,
              trailingBuilder: trailingBuilder != null
                  ? (_) => trailingBuilder!(modal)
                  : null,
              builder: listBuilder ?? ChoiceList.createVirtualized(),
            );
          },
        ),
      ),
    );
  }
}
