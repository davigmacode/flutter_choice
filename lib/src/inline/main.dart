import 'package:choice/selection.dart';
import 'package:flutter/widgets.dart';
import 'list.dart';
import 'types.dart';

/// Widget to create inline choice with single or multiple selection
class InlineChoice<T> extends ChoiceList<T> {
  /// Create inline choice widget with single or multiple selection
  ///
  /// {@macro choice.params.universal}
  ///
  /// {@macro choice.params.multiple}
  ///
  /// {@template choice.params.list}
  /// The [itemCount] prop is the total number of item, this choice list can provide
  ///
  /// The [itemSkip] prop called to specify which indices to skip when building choice item
  ///
  /// The [itemBuilder] prop called to build choice item
  ///
  /// The [dividerBuilder] prop called to build divider item
  ///
  /// The [leadingBuilder] prop called to build leading item of the item collection
  ///
  /// The [trailingBuilder] prop called to build trailing item of the item collection
  ///
  /// The [listBuilder] prop called to build the list of choice items
  /// {@endtemplate}
  ///
  /// A [StatefulWidget] that illustrates use of an [InlineChoice] usage.
  ///
  /// ```dart
  /// import 'package:flutter/material.dart';
  /// import 'package:choice/choice.dart';
  ///
  /// class InlineWrapped extends StatefulWidget {
  ///   const InlineWrapped({super.key});
  ///
  ///   @override
  ///   State<InlineWrapped> createState() => _InlineWrappedState();
  /// }
  ///
  /// class _InlineWrappedState extends State<InlineWrapped> {
  ///   List<String> choices = [
  ///     'News',
  ///     'Entertainment',
  ///     'Politics',
  ///     'Automotive',
  ///     'Sports',
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
  ///     return InlineChoice<String>(
  ///       clearable: true,
  ///       value: ChoiceSingle.value(selectedValue),
  ///       onChanged: ChoiceSingle.onChanged(setSelectedValue),
  ///       itemCount: choices.length,
  ///       itemBuilder: (selection, i) {
  ///         return ChoiceChip(
  ///           selected: selection.selected(choices[i]),
  ///           onSelected: selection.onSelected(choices[i]),
  ///           label: Text(choices[i]),
  ///         );
  ///       },
  ///       listBuilder: ChoiceList.createWrapped(
  ///         spacing: 10,
  ///         runSpacing: 10,
  ///         padding: const EdgeInsets.symmetric(
  ///           horizontal: 20,
  ///           vertical: 25,
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  const InlineChoice({
    super.key,
    this.value = const [],
    this.onChanged,
    this.multiple = false,
    this.clearable = false,
    required super.itemCount,
    required super.itemBuilder,
    super.itemSkip,
    super.dividerBuilder,
    super.leadingBuilder,
    super.trailingBuilder,
    ChoiceListBuilder? listBuilder,
  }) : super(builder: listBuilder);

  /// Create inline choice widget with single selection
  ///
  /// {@macro choice.params.universal}
  ///
  /// {@macro choice.params.list}
  ///
  /// A [StatefulWidget] that illustrates use of an [InlineChoice.single] usage.
  ///
  /// ```dart
  /// import 'package:flutter/material.dart';
  /// import 'package:choice/choice.dart';
  ///
  /// class InlineScrollableX extends StatefulWidget {
  ///   const InlineScrollableX({super.key});
  ///
  ///   @override
  ///   State<InlineScrollableX> createState() => _InlineScrollableXState();
  /// }
  ///
  /// class _InlineScrollableXState extends State<InlineScrollableX> {
  ///   List<String> choices = [
  ///     'News',
  ///     'Entertainment',
  ///     'Politics',
  ///     'Automotive',
  ///     'Sports',
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
  ///     return InlineChoice<String>.single(
  ///       clearable: true,
  ///       value: selectedValue,
  ///       onChanged: setSelectedValue,
  ///       itemCount: choices.length,
  ///       itemBuilder: (state, i) {
  ///         return ChoiceChip(
  ///           selected: state.selected(choices[i]),
  ///           onSelected: state.onSelected(choices[i]),
  ///           label: Text(choices[i]),
  ///         );
  ///       },
  ///       listBuilder: ChoiceList.createScrollable(
  ///         spacing: 10,
  ///         padding: const EdgeInsets.symmetric(
  ///           horizontal: 20,
  ///           vertical: 25,
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  InlineChoice.single({
    super.key,
    T? value,
    ValueChanged<T?>? onChanged,
    this.clearable = false,
    required super.itemCount,
    required super.itemBuilder,
    super.itemSkip,
    super.dividerBuilder,
    super.leadingBuilder,
    super.trailingBuilder,
    ChoiceListBuilder? listBuilder,
  })  : multiple = false,
        value = ChoiceSingle.value(value),
        onChanged = ChoiceSingle.onChanged(onChanged),
        super(builder: listBuilder);

  /// Create inline choice widget with multiple selection
  ///
  /// {@macro choice.params.universal}
  ///
  /// {@macro choice.params.list}
  ///
  /// A [StatefulWidget] that illustrates use of an [InlineChoice.multiple] usage.
  ///
  /// ```dart
  /// import 'package:flutter/material.dart';
  /// import 'package:choice/choice.dart';
  ///
  /// class InlineScrollableX extends StatefulWidget {
  ///   const InlineScrollableX({super.key});
  ///
  ///   @override
  ///   State<InlineScrollableX> createState() => _InlineScrollableXState();
  /// }
  ///
  /// class _InlineScrollableXState extends State<InlineScrollableX> {
  ///   List<String> choices = [
  ///     'News',
  ///     'Entertainment',
  ///     'Politics',
  ///     'Automotive',
  ///     'Sports',
  ///   ];
  ///
  ///   List<String> selectedValue = [];
  ///
  ///   void setSelectedValue(List<String> value) {
  ///     setState(() => selectedValue = value);
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return InlineChoice<String>.multiple(
  ///       clearable: true,
  ///       value: selectedValue,
  ///       onChanged: setSelectedValue,
  ///       itemCount: choices.length,
  ///       itemBuilder: (state, i) {
  ///         return ChoiceChip(
  ///           selected: state.selected(choices[i]),
  ///           onSelected: state.onSelected(choices[i]),
  ///           label: Text(choices[i]),
  ///         );
  ///       },
  ///       listBuilder: ChoiceList.createScrollable(
  ///         spacing: 10,
  ///         padding: const EdgeInsets.symmetric(
  ///           horizontal: 20,
  ///           vertical: 25,
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  const InlineChoice.multiple({
    super.key,
    this.value = const [],
    this.onChanged,
    this.clearable = false,
    required super.itemCount,
    required super.itemBuilder,
    super.itemSkip,
    super.dividerBuilder,
    super.leadingBuilder,
    super.trailingBuilder,
    ChoiceListBuilder? listBuilder,
  })  : multiple = true,
        super(builder: listBuilder);

  /// {@macro choice.multiple}
  final bool multiple;

  /// {@macro choice.clearable}
  final bool clearable;

  /// {@macro choice.value}
  final List<T> value;

  /// {@macro choice.onChanged}
  final ValueChanged<List<T>>? onChanged;

  @override
  Widget build(BuildContext context) {
    return ChoiceProvider<T>(
      controller: ChoiceController<T>(
        multiple: multiple,
        clearable: clearable,
        value: value,
        onChanged: onChanged,
      ),
      child: Builder(
        builder: (innerContext) => super.build(innerContext),
      ),
    );
  }
}
