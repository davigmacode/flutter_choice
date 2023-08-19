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
    this.mandatory = false,
    this.value = const [],
    this.onChanged,
    required this.itemCount,
    required this.itemBuilder,
    this.itemSkip = ChoiceList.defaultItemSkip,
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

  final String? title;
  final bool multiple;
  final bool mandatory;
  final List<T> value;
  final ValueChanged<List<T>>? onChanged;
  final int itemCount;
  final IndexedChoiceStateBuilder<T> itemBuilder;
  final ChoiceSkipCallback itemSkip;
  final ChoiceStateBuilder<T>? dividerBuilder;
  final ChoiceStateBuilder<T>? leadingBuilder;
  final ChoiceStateBuilder<T>? trailingBuilder;
  final ChoiceListBuilder? listBuilder;
  final ChoiceModalStateBuilder<T>? modalHeaderBuilder;
  final ChoiceModalStateBuilder<T>? modalFooterBuilder;
  final ChoiceModalStateBuilder<T>? modalSeparatorBuilder;
  final FlexFit modalFit;
  final ChoicePromptDelegate<T>? promptDelegate;
  final ChoicePromptBuilder<T>? triggerBuilder;
  final bool filterable;

  @override
  Widget build(BuildContext context) {
    return ChoiceSelection<T>(
      title: title,
      multiple: multiple,
      mandatory: mandatory,
      value: value,
      onChanged: onChanged,
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
              keyword: modal.filter.value,
              itemCount: itemCount,
              itemBuilder: itemBuilder,
              itemSkip: itemSkip,
              dividerBuilder: dividerBuilder,
              leadingBuilder: leadingBuilder,
              trailingBuilder: trailingBuilder,
              builder: listBuilder ?? ChoiceList.createVirtualized(),
            );
          },
        ),
      ),
    );
  }
}
