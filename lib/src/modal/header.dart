import 'package:flutter/material.dart';
import 'package:choice/selection.dart';
import 'filter.dart';

class ChoiceModalHeader extends AppBar {
  ChoiceModalHeader({
    super.key,
    super.primary = true,
    super.title,
    super.shape,
    super.elevation,
    super.backgroundColor,
    super.actionsIconTheme,
    super.iconTheme,
    super.centerTitle,
    super.automaticallyImplyLeading = true,
    super.leading,
    super.actions,
  });

  static ChoiceStateBuilder<T> createBuilder<T>({
    Key? key,
    Widget? title,
    ShapeBorder? shape,
    double? elevation,
    Color? backgroundColor,
    IconThemeData? actionsIconTheme,
    IconThemeData? iconTheme,
    bool? centerTitle,
    bool automaticallyImplyLeading = true,
    ChoiceStateBuilder<T>? filterBuilder,
    ChoiceStateBuilder<T>? filterToggleBuilder,
    List<ChoiceStateBuilder<T>>? actionsBuilder,
  }) {
    final effectiveFilterBuilder =
        filterBuilder ?? ChoiceFilter.createBuilder<T>();
    final effectiveFilterToggleBuilder =
        filterToggleBuilder ?? ChoiceFilterToggle.createBuilder<T>();
    return (state) {
      final filterable = state.filterable;
      final filtering = state.filter?.active ?? false;
      final filter = effectiveFilterBuilder(state);
      final effectiveTitle =
          title ?? (state.title != null ? Text(state.title!) : null);
      final actions =
          actionsBuilder?.map((actionBuilder) => actionBuilder(state));
      return ChoiceModalHeader(
        key: key,
        shape: shape,
        elevation: elevation,
        backgroundColor: backgroundColor,
        actionsIconTheme: actionsIconTheme,
        iconTheme: iconTheme,
        centerTitle: centerTitle,
        automaticallyImplyLeading:
            automaticallyImplyLeading || (filterable && filtering),
        leading:
            filterable && filtering ? ChoiceFilterToggle.defaultIconShow : null,
        title: filterable && filtering ? filter : effectiveTitle,
        actions: [
          if (filterable) effectiveFilterToggleBuilder(state),
          if (!filtering) ...?actions,
        ],
      );
    };
  }
}
