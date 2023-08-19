import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:choice/selection.dart';
import 'placeholder.dart';
import 'types.dart';

class ChoiceList<T> extends StatelessWidget {
  const ChoiceList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.itemSkip = defaultItemSkip,
    this.dividerBuilder,
    this.leadingBuilder,
    this.trailingBuilder,
    this.builder,
    this.keyword,
  });

  final int itemCount;
  final IndexedChoiceStateBuilder<T> itemBuilder;
  final ChoiceSkipCallback itemSkip;
  final ChoiceStateBuilder<T>? dividerBuilder;
  final ChoiceStateBuilder<T>? leadingBuilder;
  final ChoiceStateBuilder<T>? trailingBuilder;
  final ChoiceListBuilder? builder;
  final String? keyword;

  bool get hasDivider => dividerBuilder != null;
  bool get hasLeading => leadingBuilder != null;
  bool get hasTrailing => trailingBuilder != null;

  static final defaultBuilder = createWrapped();

  static const ChoiceSkipCallback defaultItemSkip = _defaultItemSkip;
  static bool _defaultItemSkip(String? keyword, int i) {
    return false;
  }

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
      return Padding(
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
          ).where((e) => e is! SizedBox).toList(),
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
          ).where((e) => e is! SizedBox).toList(),
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

  IndexedChoiceBuilder resolveItemBuilderWithAdditional(
    ChoiceSelectionController<T> state,
  ) {
    return (i) {
      if (hasLeading && i == 0) {
        return leadingBuilder!(state);
      }
      if (hasTrailing && i == (resolveItemCount() - 1)) {
        return trailingBuilder!(state);
      }
      if (!itemSkip(keyword, i)) {
        return itemBuilder(state, hasLeading ? i - 1 : i);
      }
      return const SizedBox();
    };
  }

  IndexedChoiceBuilder resolveItemBuilderWithDivider(
    ChoiceSelectionController<T> state,
  ) {
    return (i) {
      final int itemIndex = i ~/ 2;
      if (i.isEven) {
        return resolveItemBuilderWithAdditional(state)(itemIndex);
      }
      return dividerBuilder!(state);
    };
  }

  IndexedChoiceBuilder resolveItemBuilder(
    ChoiceSelectionController<T> state,
  ) {
    return (i) {
      return hasDivider
          ? resolveItemBuilderWithDivider(state)(i)
          : resolveItemBuilderWithAdditional(state)(i);
    };
  }

  int resolveSkippedItemCount() {
    return List<bool>.generate(itemCount, (i) => itemSkip(keyword, i))
        .where((e) => e == true)
        .length;
  }

  int resolveItemCount() {
    int count = itemCount;
    if (hasLeading) {
      count += 1;
    }
    if (hasTrailing) {
      count += 1;
    }
    if (hasDivider) {
      count = count * 2 - 1;
    }
    return math.max(0, count);
  }

  @override
  Widget build(BuildContext context) {
    return ChoiceSelectionConsumer<T>(
      builder: (state, _) {
        final itemCount = resolveItemCount();
        return itemCount - resolveSkippedItemCount() > 0
            ? (builder ?? defaultBuilder).call(
                resolveItemBuilder(state),
                itemCount,
              )
            : const ChoiceListPlaceholder();
      },
    );
  }
}
