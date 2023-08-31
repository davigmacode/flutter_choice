import 'package:flutter/material.dart';
import 'package:choice/selection.dart';
import 'types.dart';

abstract class ChoiceGroup {
  static const defaultListPadding = EdgeInsets.symmetric(
    vertical: 20,
  );

  static const defaultHeaderPadding = EdgeInsets.symmetric(
    horizontal: 20.0,
  );

  /// Create default group list builder
  static ChoiceGroupBuilder createList({
    bool shrinkWrap = true,
    ScrollPhysics? physics,
    EdgeInsetsGeometry? padding = defaultListPadding,
  }) {
    return (itemBuilder, itemCount) {
      return ListView.builder(
        primary: false,
        padding: padding,
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemCount: itemCount,
        itemBuilder: (context, i) => itemBuilder(i),
      );
    };
  }

  /// Create default group item builder
  static ChoiceGroupItemBuilder createItem() {
    return (header, choices) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[header, choices],
      );
    };
  }

  /// Create default group header builder
  static ChoiceGroupHeaderBuilder createHeader({
    bool? dense,
    TextStyle? textStyle,
    EdgeInsetsGeometry? contentPadding = defaultHeaderPadding,
    bool hideCounter = false,
  }) {
    return (name, indices) {
      return Builder(
        builder: (context) {
          final effectiveTextStyle =
              textStyle ?? Theme.of(context).textTheme.titleSmall;
          return ListTile(
            dense: dense,
            title: Text(name),
            trailing: !hideCounter ? Text(indices.length.toString()) : null,
            titleTextStyle: effectiveTextStyle,
            leadingAndTrailingTextStyle: effectiveTextStyle,
            contentPadding: contentPadding,
          );
        },
      );
    };
  }

  /// Create selectable group header builder
  static ChoiceGroupHeaderBuilder<T> createSelectableHeader<T>({
    bool? dense,
    TextStyle? textStyle,
    EdgeInsetsGeometry? contentPadding = defaultHeaderPadding,
    bool hideCounter = false,
    required T Function(int i) valueResolver,
  }) {
    return (name, indices) {
      return Builder(
        builder: (context) {
          final effectiveTextStyle =
              textStyle ?? Theme.of(context).textTheme.titleSmall;
          final values = indices.map(valueResolver).whereType<T>().toList();
          return ChoiceConsumer<T>(builder: (state, _) {
            return ListTile(
              dense: dense,
              title: Row(
                children: [
                  Text(name),
                  if (!hideCounter) const Text(' - '),
                  if (!hideCounter) Text(indices.length.toString()),
                ],
              ),
              trailing: Checkbox(
                value: state.selectedMany(values),
                onChanged: state.onSelectedMany(values),
                tristate: true,
              ),
              titleTextStyle: effectiveTextStyle,
              leadingAndTrailingTextStyle: effectiveTextStyle,
              contentPadding: contentPadding,
              onTap: () {
                state.selectMany(values);
              },
            );
          });
        },
      );
    };
  }
}
