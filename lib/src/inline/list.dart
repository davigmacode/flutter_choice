import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';
import 'group.dart';
import 'placeholder.dart';
import 'error.dart';
import 'loader.dart';
import 'types.dart';

class ChoiceList<T> extends StatelessWidget {
  const ChoiceList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.itemSkip,
    this.itemGroup,
    this.dividerBuilder,
    this.leadingBuilder,
    this.trailingBuilder,
    this.placeholderBuilder,
    this.errorBuilder,
    this.loaderBuilder,
    this.groupSort,
    this.groupBuilder,
    this.groupItemBuilder,
    this.groupHeaderBuilder,
    this.builder,
    this.loading = false,
    this.error = false,
  });

  /// {@macro choice.loading}
  final bool loading;

  /// {@macro choice.error}
  final bool error;

  /// {@template choice.list.itemCount}
  /// The total number of item, this choice list can provide
  /// {@endtemplate}
  final int itemCount;

  /// {@template choice.list.itemBuilder}
  /// Called to build choice item
  /// {@endtemplate}
  final IndexedChoiceStateBuilder<T> itemBuilder;

  /// {@template choice.list.itemSkip}
  /// Called to specify which indices to skip when building choice item
  /// {@endtemplate}
  final ChoiceSkipResolver<T>? itemSkip;

  /// {@template choice.list.itemGroup}
  /// Called to enable grouped choices and specify group name of choice item
  /// {@endtemplate}
  final ChoiceGroupResolver? itemGroup;

  /// {@template choice.list.dividerBuilder}
  /// Called to build divider item
  /// {@endtemplate}
  final ChoiceStateBuilder<T>? dividerBuilder;

  /// {@template choice.list.leadingBuilder}
  /// Called to build leading item of the item collection
  /// {@endtemplate}
  final ChoiceStateBuilder<T>? leadingBuilder;

  /// {@template choice.list.trailingBuilder}
  /// Called to build trailing item of the item collection
  /// {@endtemplate}
  final ChoiceStateBuilder<T>? trailingBuilder;

  /// {@template choice.list.placeholderBuilder}
  /// Called to build placeholder when there are no choice items
  /// {@endtemplate}
  final ChoiceStateBuilder<T>? placeholderBuilder;

  /// {@template choice.list.errorBuilder}
  /// Called to build an error indicator widget when choice list cannot be shown
  /// {@endtemplate}
  final ChoiceStateBuilder<T>? errorBuilder;

  /// {@template choice.list.loaderBuilder}
  /// Called to build loading indicator when [loading] is true
  /// {@endtemplate}
  final ChoiceStateBuilder<T>? loaderBuilder;

  /// {@template choice.list.groupBuilder}
  /// Called to build the grouped list of choice items
  /// {@endtemplate}
  final ChoiceGroupBuilder? groupBuilder;

  /// {@template choice.list.groupItemBuilder}
  /// Called to build the grouped item of choice items
  /// {@endtemplate}
  final ChoiceGroupItemBuilder? groupItemBuilder;

  /// {@template choice.list.groupHeaderBuilder}
  /// Called to build the grouped header of choice items
  /// {@endtemplate}
  final ChoiceGroupHeaderBuilder<T>? groupHeaderBuilder;

  /// {@template choice.list.groupSort}
  /// If provided, sort group by the given callback
  /// {@endtemplate}
  final ChoiceGroupSortResolver? groupSort;

  /// {@template choice.list.builder}
  /// Called to build the list of choice items
  /// {@endtemplate}
  final ChoiceListBuilder? builder;

  /// Indicates whether the choice items is grouped
  bool get isGrouped => itemGroup != null;

  /// Indicates whether the choice list has divider item
  bool get hasDivider => dividerBuilder != null;

  /// Indicates whether the choice list has leading item
  bool get hasLeading => leadingBuilder != null;

  /// Indicates whether the choice list has trailing item
  bool get hasTrailing => trailingBuilder != null;

  static final defaultBuilder = createWrapped();

  static final defaultGroupBuilder = ChoiceGroup.createList();

  static final defaultGroupItemBuilder = ChoiceGroup.createItem();

  static bool defaultItemSkip<T>(ChoiceController<T> state, int i) => false;

  ChoiceSkipResolver<T> get effectiveItemSkip => itemSkip ?? defaultItemSkip;

  ChoiceStateBuilder<T> get effectiveLoadingBuilder {
    return loaderBuilder ?? ChoiceListLoader.createCircularLoader();
  }

  ChoiceStateBuilder<T> get effectivePlaceholderBuilder {
    return placeholderBuilder ?? ChoiceListPlaceholder.create();
  }

  ChoiceStateBuilder<T> get effectiveErrorBuilder {
    return errorBuilder ??
        ChoiceListError.create(
          message: 'The choice list failed to load',
        );
  }

  ChoiceListBuilder get effectiveListBuilder => builder ?? defaultBuilder;

  ChoiceGroupBuilder get effectiveGroupBuilder =>
      groupBuilder ?? defaultGroupBuilder;

  ChoiceGroupItemBuilder get effectiveGroupItemBuilder =>
      groupItemBuilder ?? defaultGroupItemBuilder;

  ChoiceGroupHeaderBuilder<T> get effectiveGroupHeaderBuilder =>
      groupHeaderBuilder ?? ChoiceGroup.createHeader();

  List<ChoiceItemBuilder?> _resolveSkippedItems(ChoiceController<T> state) {
    return List<ChoiceItemBuilder?>.generate(
      itemCount,
      (i) => !effectiveItemSkip(state, i) ? () => itemBuilder(state, i) : null,
    );
  }

  List<ChoiceItemBuilder> _resolveDividedItems(
    ChoiceController<T> state,
    List<ChoiceItemBuilder> items,
  ) {
    if (hasDivider) {
      final count = items.length;
      for (var i = count - 1; i > 0; i--) {
        items.insert(i, () => dividerBuilder!(state));
      }
    }
    return items;
  }

  List<ChoiceItemBuilder> _resolveComposedItems(
    ChoiceController<T> state,
    List<ChoiceItemBuilder?> items,
  ) {
    final composedItems = <ChoiceItemBuilder>[
      if (hasLeading) () => leadingBuilder!(state),
      ...items.whereType<ChoiceItemBuilder>().toList(),
      if (hasTrailing) () => trailingBuilder!(state),
    ];
    return _resolveDividedItems(state, composedItems);
  }

  Widget _buildLayout(
    ChoiceController<T> state,
    bool isEmpty,
    Widget Function() listBuilder,
  ) {
    return !loading
        ? !error
            ? itemCount > 0
                ? listBuilder()
                : effectivePlaceholderBuilder(state)
            : effectiveErrorBuilder(state)
        : effectiveLoadingBuilder(state);
  }

  Widget _buildNonGrouped(
    ChoiceController<T> state,
    List<ChoiceItemBuilder?> items,
  ) {
    final itemBuilders = _resolveComposedItems(state, items);
    final itemCount = itemBuilders.length;
    return _buildLayout(
      state,
      itemBuilders.isEmpty,
      () => effectiveListBuilder.call(
        (i) => itemBuilders[i](),
        itemCount,
      ),
    );
  }

  Widget _buildGrouped(
    ChoiceController<T> state,
    List<ChoiceItemBuilder?> items,
  ) {
    /// name => index => builder
    final Map<String, Map<int, ChoiceItemBuilder>> groups = {};
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      if (item != null) {
        final name = itemGroup!(i);
        groups[name] = {
          ...?groups[name],
          ...{i: item}
        };
      }
    }
    final groupEntries = groups.entries.toList();
    if (groupSort != null) {
      groupEntries.sort((a, b) => groupSort!(a.key, b.key));
    }
    return _buildLayout(
      state,
      groups.isEmpty,
      () => effectiveGroupBuilder.call(
        (i) {
          final entry = groupEntries.elementAt(i);
          final groupName = entry.key;
          final groupIndexedBuilders = entry.value;
          final groupBuilders = groupIndexedBuilders.values;
          final groupIndices = groupIndexedBuilders.keys.toList();
          final header = effectiveGroupHeaderBuilder(groupName, groupIndices);
          final choices = effectiveListBuilder.call(
            (j) => groupBuilders.elementAt(j)(),
            groupBuilders.length,
          );
          return effectiveGroupItemBuilder(header, choices);
        },
        groupEntries.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ChoiceProvider.of<T>(context);
    final itemBuilders = _resolveSkippedItems(state);
    return isGrouped
        ? _buildGrouped(state, itemBuilders)
        : _buildNonGrouped(state, itemBuilders);
  }

  static ChoiceListBuilder createWrapped({
    Axis direction = Axis.horizontal,
    WrapAlignment alignment = WrapAlignment.start,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double spacing = 10.0,
    WrapAlignment runAlignment = WrapAlignment.start,
    double runSpacing = 10.0,
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    Clip clipBehavior = Clip.none,
  }) {
    return (itemBuilder, itemCount) {
      return IntrinsicWidth(
        child: Padding(
          padding: padding,
          child: Wrap(
            direction: direction,
            alignment: alignment,
            spacing: spacing,
            runAlignment: runAlignment,
            runSpacing: runSpacing,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
            clipBehavior: clipBehavior,
            children: List<Widget>.generate(
              itemCount,
              (i) => itemBuilder(i),
            ),
          ),
        ),
      );
    };
  }

  static ChoiceListBuilder createScrollable({
    Axis direction = Axis.horizontal,
    double spacing = 0.0,
    double runSpacing = 0.0,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    WrapAlignment alignment = WrapAlignment.start,
    WrapAlignment runAlignment = WrapAlignment.start,
    WrapCrossAlignment crossAxisAlignment = WrapCrossAlignment.start,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    Clip clipBehavior = Clip.none,
  }) {
    return (itemBuilder, itemCount) {
      return SingleChildScrollView(
        primary: false,
        padding: padding,
        scrollDirection: direction,
        child: Wrap(
          direction: direction,
          alignment: alignment,
          spacing: spacing,
          runAlignment: runAlignment,
          runSpacing: runSpacing,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          clipBehavior: clipBehavior,
          children: List<Widget>.generate(
            itemCount,
            (i) => itemBuilder(i),
          ),
        ),
      );
    };
  }

  static ChoiceListBuilder createVirtualized({
    bool shrinkWrap = false,
    ScrollPhysics? physics,
    Axis direction = Axis.vertical,
    EdgeInsetsGeometry? padding,
  }) {
    return (itemBuilder, itemCount) {
      return ListView.builder(
        primary: false,
        shrinkWrap: shrinkWrap,
        physics: physics,
        scrollDirection: direction,
        padding: padding,
        itemCount: itemCount,
        itemBuilder: (context, i) => itemBuilder(i),
      );
    };
  }

  static ChoiceListBuilder createGrid({
    bool shrinkWrap = true,
    ScrollPhysics? physics,
    SliverGridDelegate? delegate,
    Axis direction = Axis.vertical,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double spacing = 0.0,
    int columns = 2,
    double childAspectRatio = 1.0,
  }) {
    return (itemBuilder, itemCount) {
      return GridView.builder(
        primary: false,
        shrinkWrap: shrinkWrap,
        physics: physics,
        scrollDirection: direction,
        padding: padding,
        itemCount: itemCount,
        itemBuilder: (context, i) => itemBuilder(i),
        gridDelegate: delegate ??
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              childAspectRatio: childAspectRatio,
            ),
      );
    };
  }
}
