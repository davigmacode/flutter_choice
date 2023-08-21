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

  final String? title;
  final bool multiple;
  final bool mandatory;
  final bool confirmation;
  final List<T> value;
  final ValueChanged<List<T>>? onChanged;
  final int itemCount;
  final IndexedChoiceModalStateBuilder<T> itemBuilder;
  final ChoiceSkipCallback? itemSkip;
  final ChoiceModalStateBuilder<T>? dividerBuilder;
  final ChoiceModalStateBuilder<T>? leadingBuilder;
  final ChoiceModalStateBuilder<T>? trailingBuilder;
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
      confirmation: confirmation,
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
