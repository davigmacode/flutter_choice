import 'package:flutter/material.dart';
import 'filter.dart';
import 'types.dart';

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

  static ChoiceModalStateBuilder<T> createBuilder<T>({
    Key? key,
    Widget? title,
    ShapeBorder? shape,
    double? elevation,
    Color? backgroundColor,
    IconThemeData? actionsIconTheme,
    IconThemeData? iconTheme,
    bool? centerTitle,
    bool automaticallyImplyLeading = true,
    List<ChoiceModalStateBuilder>? actionsBuilder,
  }) {
    final filterBuilder = ChoiceFilter.createBuilder();
    final filterToggleBuilder = ChoiceFilterToggle.createBuilder();
    return (state) {
      final filterable = state.filterable;
      final filtering = state.filter.displayed;
      final filter = filterBuilder(state);
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
          if (filterable) filterToggleBuilder(state),
          if (!filtering) ...?actions,
        ],
      );
    };
  }
}
