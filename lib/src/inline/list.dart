import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';
import 'placeholder.dart';
import 'loader.dart';
import 'types.dart';

class ChoiceList<T> extends StatelessWidget {
  const ChoiceList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.itemSkip,
    this.dividerBuilder,
    this.leadingBuilder,
    this.trailingBuilder,
    this.placeholderBuilder,
    this.errorBuilder,
    this.loaderBuilder,
    this.builder,
    this.loading = false,
  });

  /// {@macro choice.loading}
  final bool loading;

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
  final ChoiceSkipCallback? itemSkip;

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

  /// {@template choice.list.builder}
  /// Called to build the list of choice items
  /// {@endtemplate}
  final ChoiceListBuilder? builder;

  /// Indicates whether the choice list has divider item
  bool get hasDivider => dividerBuilder != null;

  /// Indicates whether the choice list has leading item
  bool get hasLeading => leadingBuilder != null;

  /// Indicates whether the choice list has trailing item
  bool get hasTrailing => trailingBuilder != null;

  /// Indicates whether the choice list has error
  bool get hasError => errorBuilder != null;

  static final defaultBuilder = createWrapped();

  static bool defaultItemSkip(String? keyword, int i) => false;

  static ChoiceListBuilder createWrapped({
    Axis direction = Axis.horizontal,
    WrapAlignment alignment = WrapAlignment.start,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double spacing = 0.0,
    WrapAlignment runAlignment = WrapAlignment.start,
    double runSpacing = 0.0,
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

  List<ChoiceItemBuilder> _resolveSearchedItems(ChoiceController<T> state) {
    final effectiveItemSkip = itemSkip ?? defaultItemSkip;
    return List<ChoiceItemBuilder?>.generate(
      itemCount,
      (i) => !effectiveItemSkip(state.search?.value, i)
          ? () => itemBuilder(state, i)
          : null,
    ).whereType<ChoiceItemBuilder>().toList();
  }

  List<ChoiceItemBuilder> _resolveItems(ChoiceController<T> state) {
    final items = <ChoiceItemBuilder>[
      if (hasLeading) () => leadingBuilder!(state),
      ..._resolveSearchedItems(state),
      if (hasTrailing) () => trailingBuilder!(state),
    ];
    return _resolveDividedItems(state, items);
  }

  ChoiceStateBuilder<T> get effectiveLoadingBuilder {
    return loaderBuilder ?? ChoiceListLoader.createCircularLoader();
  }

  ChoiceStateBuilder<T> get effectivePlaceholderBuilder {
    return placeholderBuilder ?? ChoiceListPlaceholder.createBuilder();
  }

  @override
  Widget build(BuildContext context) {
    final state = ChoiceProvider.of<T>(context);
    final itemBuildersPool = _resolveItems(state);
    final itemCount = itemBuildersPool.length;
    return !loading
        ? !hasError
            ? itemCount > 0
                ? (builder ?? defaultBuilder).call(
                    (i) => itemBuildersPool[i](),
                    itemCount,
                  )
                : effectivePlaceholderBuilder(state)
            : errorBuilder!(state)
        : effectiveLoadingBuilder(state);
  }
}
