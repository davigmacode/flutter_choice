import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';
import 'package:choice/inline.dart';
import 'package:choice/modal.dart';
import 'package:choice/anchor.dart';
import 'package:choice/utils.dart';
import 'delegate.dart';
import 'types.dart';

/// Widget to create prompted choice with single or multiple selection
class PromptedChoice<T> extends StatefulWidget {
  /// Create prompted choice widget with single or multiple selection
  ///
  /// {@macro choice.params.universal}
  ///
  /// {@macro choice.params.multiple}
  ///
  /// {@macro choice.params.prompt}
  ///
  /// {@macro choice.params.list}
  ///
  /// {@template choice.params.modal}
  /// The [modalBodyBuilder] prop called to build modal body widget
  ///
  /// The [modalHeaderBuilder] prop called to build modal header widget
  ///
  /// The [modalFooterBuilder] prop called to build modal footer widget
  ///
  /// The [modalSeparatorBuilder] prop called to build modal separator widget
  ///
  /// The [modalFit] prop is how a flexible modal body is inscribed into the available space.
  ///
  /// The [anchorBuilder] prop called to build trigger widget to invoke modal prompt
  ///
  /// The [promptDelegate] prop called to specify ways to invoke modal prompt
  /// {@endtemplate}
  ///
  /// A [StatefulWidget] that illustrates use of an [PromptedChoice] usage.
  ///
  /// ```dart
  /// import 'package:flutter/material.dart';
  /// import 'package:choice/choice.dart';
  ///
  /// class PromptedPopupDialog extends StatefulWidget {
  ///   const PromptedPopupDialog({super.key});
  ///
  ///   @override
  ///   State<PromptedPopupDialog> createState() => _PromptedPopupDialogState();
  /// }
  ///
  /// class _PromptedPopupDialogState extends State<PromptedPopupDialog> {
  ///   List<String> choices = [
  ///     'News',
  ///     'Entertainment',
  ///     'Politics',
  ///     'Automotive',
  ///     'Sports',
  ///     'Education',
  ///   ];
  ///
  ///   String? selectedValue;
  ///
  ///   void setSelectedValue(String? value) {
  ///     setState(() => selectedValue = value);
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return SizedBox(
  ///       width: 300,
  ///       child: Card(
  ///         clipBehavior: Clip.antiAlias,
  ///         child: PromptedChoice<String>(
  ///           title: 'Category',
  ///           value: ChoiceSingle.value(selectedValue),
  ///           onChanged: ChoiceSingle.onChanged(setSelectedValue),
  ///           itemCount: choices.length,
  ///           itemBuilder: (state, i) {
  ///             return RadioListTile(
  ///               value: choices[i],
  ///               groupValue: state.single,
  ///               onChanged: (value) {
  ///                 state.select(choices[i]);
  ///               },
  ///               title: ChoiceText(
  ///                 choices[i],
  ///                 highlight: state.search?.value,
  ///               ),
  ///             );
  ///           },
  ///           promptDelegate: ChoicePrompt.delegatePopupDialog(
  ///             maxHeightFactor: .5,
  ///             constraints: const BoxConstraints(maxWidth: 300),
  ///           ),
  ///           anchorBuilder: ChoiceAnchor.create(inline: true),
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  const PromptedChoice({
    super.key,
    this.title,
    this.multiple = false,
    this.clearable = false,
    this.confirmation = false,
    this.loading = false,
    this.error = false,
    this.value = const [],
    this.onChanged,
    required this.itemCount,
    required this.itemBuilder,
    this.itemSkip,
    this.dividerBuilder,
    this.leadingBuilder,
    this.trailingBuilder,
    this.placeholderBuilder,
    this.errorBuilder,
    this.loaderBuilder,
    this.listBuilder,
    this.modalHeaderBuilder,
    this.modalFooterBuilder,
    this.modalSeparatorBuilder,
    this.modalFit = FlexFit.loose,
    this.anchorBuilder,
    this.promptDelegate,
    this.searchable = false,
    this.onSearch,
  });

  /// Create prompted choice widget with single selection
  ///
  /// {@macro choice.params.universal}
  ///
  /// {@macro choice.params.prompt}
  ///
  /// {@macro choice.params.list}
  ///
  /// {@macro choice.params.modal}
  ///
  /// A [StatefulWidget] that illustrates use of an [PromptedChoice.single] usage.
  ///
  /// ```dart
  /// import 'package:flutter/material.dart';
  /// import 'package:choice/choice.dart';
  ///
  /// class PromptedPopupDialog extends StatefulWidget {
  ///   const PromptedPopupDialog({super.key});
  ///
  ///   @override
  ///   State<PromptedPopupDialog> createState() => _PromptedPopupDialogState();
  /// }
  ///
  /// class _PromptedPopupDialogState extends State<PromptedPopupDialog> {
  ///   List<String> choices = [
  ///     'News',
  ///     'Entertainment',
  ///     'Politics',
  ///     'Automotive',
  ///     'Sports',
  ///     'Education',
  ///   ];
  ///
  ///   String? selectedValue;
  ///
  ///   void setSelectedValue(String? value) {
  ///     setState(() => selectedValue = value);
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return SizedBox(
  ///       width: 300,
  ///       child: Card(
  ///         clipBehavior: Clip.antiAlias,
  ///         child: PromptedChoice<String>(
  ///           title: 'Category',
  ///           value: selectedValue,
  ///           onChanged: setSelectedValue,
  ///           itemCount: choices.length,
  ///           itemBuilder: (state, i) {
  ///             return RadioListTile(
  ///               value: choices[i],
  ///               groupValue: state.single,
  ///               onChanged: (value) {
  ///                 state.select(choices[i]);
  ///               },
  ///               title: ChoiceText(
  ///                 choices[i],
  ///                 highlight: state.search?.value,
  ///               ),
  ///             );
  ///           },
  ///           promptDelegate: ChoicePrompt.delegatePopupDialog(
  ///             maxHeightFactor: .5,
  ///             constraints: const BoxConstraints(maxWidth: 300),
  ///           ),
  ///           anchorBuilder: ChoiceAnchor.create(inline: true),
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  PromptedChoice.single({
    super.key,
    this.title,
    this.clearable = false,
    this.confirmation = false,
    this.loading = false,
    this.error = false,
    T? value,
    ValueChanged<T?>? onChanged,
    required this.itemCount,
    required this.itemBuilder,
    this.itemSkip,
    this.dividerBuilder,
    this.leadingBuilder,
    this.trailingBuilder,
    this.placeholderBuilder,
    this.errorBuilder,
    this.loaderBuilder,
    this.listBuilder,
    this.modalHeaderBuilder,
    this.modalFooterBuilder,
    this.modalSeparatorBuilder,
    this.modalFit = FlexFit.loose,
    this.anchorBuilder,
    this.promptDelegate,
    this.searchable = false,
    this.onSearch,
  })  : multiple = false,
        value = ChoiceSingle.value(value),
        onChanged = ChoiceSingle.onChanged(onChanged);

  /// Create prompted choice widget with multiple selection
  ///
  /// {@macro choice.params.universal}
  ///
  /// {@macro choice.params.prompt}
  ///
  /// {@macro choice.params.list}
  ///
  /// ```dart
  /// import 'package:flutter/material.dart';
  /// import 'package:choice/choice.dart';
  ///
  /// class PromptedBottomSheet extends StatefulWidget {
  ///   const PromptedBottomSheet({super.key});
  ///
  ///   @override
  ///   State<PromptedBottomSheet> createState() => _PromptedBottomSheetState();
  /// }
  ///
  /// class _PromptedBottomSheetState extends State<PromptedBottomSheet> {
  ///   List<String> choices = [
  ///     'News',
  ///     'Entertainment',
  ///     'Politics',
  ///     'Automotive',
  ///     'Sports',
  ///   ];
  ///   List<String> selectedValue = [];
  ///
  ///   void setSelectedValue(List<String> value) {
  ///     setState(() => selectedValue = value);
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return SizedBox(
  ///       width: 300,
  ///       child: Card(
  ///         margin: const EdgeInsets.symmetric(vertical: 20),
  ///         child: PromptedChoice<String>.multiple(
  ///           title: 'Categories',
  ///           confirmation: true,
  ///           value: selectedValue,
  ///           onChanged: setSelectedValue,
  ///           itemCount: choices.length,
  ///           itemBuilder: (state, i) {
  ///             return CheckboxListTile(
  ///               value: state.selected(choices[i]),
  ///               onChanged: state.onSelected(choices[i]),
  ///               title: ChoiceText(
  ///                 choices[i],
  ///                 highlight: state.search?.value,
  ///               ),
  ///             );
  ///           },
  ///           modalHeaderBuilder: ChoiceModalHeader.createBuilder(
  ///             automaticallyImplyLeading: false,
  ///             actionsBuilder: [
  ///               ChoiceConfirmButton.createBuilder(),
  ///               ChoiceModal.createBuilder(
  ///                 child: const SizedBox(width: 20),
  ///               ),
  ///             ],
  ///           ),
  ///           promptDelegate: ChoicePrompt.delegateBottomSheet(),
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  const PromptedChoice.multiple({
    super.key,
    this.title,
    this.clearable = false,
    this.confirmation = false,
    this.loading = false,
    this.error = false,
    this.value = const [],
    this.onChanged,
    required this.itemCount,
    required this.itemBuilder,
    this.itemSkip,
    this.dividerBuilder,
    this.leadingBuilder,
    this.trailingBuilder,
    this.placeholderBuilder,
    this.errorBuilder,
    this.loaderBuilder,
    this.listBuilder,
    this.modalHeaderBuilder,
    this.modalFooterBuilder,
    this.modalSeparatorBuilder,
    this.modalFit = FlexFit.loose,
    this.anchorBuilder,
    this.promptDelegate,
    this.searchable = false,
    this.onSearch,
  }) : multiple = true;

  /// {@macro choice.title}
  final String? title;

  /// {@macro choice.multiple}
  final bool multiple;

  /// {@macro choice.clearable}
  final bool clearable;

  /// {@macro choice.confirmation}
  final bool confirmation;

  /// {@macro choice.loading}
  final bool loading;

  /// {@macro choice.error}
  final bool error;

  /// {@macro choice.value}
  final List<T> value;

  /// {@macro choice.onChanged}
  final ValueChanged<List<T>>? onChanged;

  /// {@macro choice.list.itemCount}
  final int itemCount;

  /// {@macro choice.list.itemBuilder}
  final IndexedChoiceStateBuilder<T> itemBuilder;

  /// {@macro choice.list.itemSkip}
  final ChoiceSkipCallback? itemSkip;

  /// {@macro choice.list.dividerBuilder}
  final ChoiceStateBuilder<T>? dividerBuilder;

  /// {@macro choice.list.leadingBuilder}
  final ChoiceStateBuilder<T>? leadingBuilder;

  /// {@macro choice.list.trailingBuilder}
  final ChoiceStateBuilder<T>? trailingBuilder;

  /// {@macro choice.list.placeholderBuilder}
  final ChoiceStateBuilder<T>? placeholderBuilder;

  /// {@macro choice.list.errorBuilder}
  final ChoiceStateBuilder<T>? errorBuilder;

  /// {@macro choice.list.loaderBuilder}
  final ChoiceStateBuilder<T>? loaderBuilder;

  /// {@macro choice.list.builder}
  final ChoiceListBuilder? listBuilder;

  /// {@macro choice.modal.headerBuilder}
  final ChoiceStateBuilder<T>? modalHeaderBuilder;

  /// {@macro choice.modal.footerBuilder}
  final ChoiceStateBuilder<T>? modalFooterBuilder;

  /// {@macro choice.modal.separatorBuilder}
  final ChoiceStateBuilder<T>? modalSeparatorBuilder;

  /// {@macro choice.modal.fit}
  final FlexFit modalFit;

  /// {@template choice.prompt.delegate}
  /// Called to specify ways to invoke modal prompt
  /// {@endtemplate}
  final ChoicePromptDelegate<T>? promptDelegate;

  /// {@template choice.prompt.trigger}
  /// Called to build trigger widget to invoke modal prompt
  /// {@endtemplate}
  final ChoicePromptBuilder<T>? anchorBuilder;

  /// {@macro choice.searchable}
  final bool searchable;

  /// {@template choice.onSearch}
  /// Called when search value changed
  /// {@endtemplate}
  final ValueSetter<String>? onSearch;

  static final defaultListBuilder = ChoiceList.createVirtualized();

  Widget get modal {
    return ChoiceModal<T>(
      fit: modalFit,
      headerBuilder: modalHeaderBuilder,
      footerBuilder: modalFooterBuilder,
      separatorBuilder: modalSeparatorBuilder,
      bodyBuilder: (state) {
        return ChoiceList<T>(
          loading: loading,
          error: error,
          itemSkip: itemSkip,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          dividerBuilder: dividerBuilder,
          leadingBuilder: leadingBuilder,
          trailingBuilder: trailingBuilder,
          placeholderBuilder: placeholderBuilder,
          errorBuilder: errorBuilder,
          loaderBuilder: loaderBuilder,
          builder: listBuilder ?? PromptedChoice.defaultListBuilder,
        );
      },
    );
  }

  @override
  State<PromptedChoice<T>> createState() => _PromptedChoiceState<T>();
}

class _PromptedChoiceState<T> extends State<PromptedChoice<T>> {
  StateSetter? _rebuildModal;

  ChoicePromptDelegate<T> get effectivePromptDelegate =>
      widget.promptDelegate ?? ChoicePrompt.delegatePopupDialog<T>();

  ChoicePromptBuilder<T> get effectiveAnchorBuilder =>
      widget.anchorBuilder ?? ChoiceAnchor.create();

  VoidCallback createOpenModal(
    BuildContext context,
    ChoiceController<T> state,
  ) {
    return () async {
      final res = await effectivePromptDelegate(
        context,
        Builder(
          builder: (modalContext) {
            return ChoiceProvider<T>(
              controller: ChoiceController.createModalController(
                modalContext: modalContext,
                rootController: state,
                searchable: widget.searchable,
                onSearch: widget.onSearch,
              ),
              child: SafeStatefulBuilder(
                builder: (_, setModalState) {
                  _rebuildModal = setModalState;
                  return widget.modal;
                },
              ),
            );
          },
        ),
      );
      if (res != null) {
        state.replace(res);
      }
    };
  }

  @override
  void didUpdateWidget(covariant PromptedChoice<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.modal != oldWidget.modal) {
      Future.delayed(Duration.zero, () async {
        _rebuildModal?.call(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChoiceProvider<T>.builder(
      controller: ChoiceController<T>(
        title: widget.title,
        multiple: widget.multiple,
        clearable: widget.clearable,
        confirmation: widget.confirmation,
        loading: widget.loading,
        error: widget.error,
        value: widget.value,
        onChanged: widget.onChanged,
      ),
      builder: (state, child) {
        return effectiveAnchorBuilder(state, createOpenModal(context, state));
      },
    );
  }
}
