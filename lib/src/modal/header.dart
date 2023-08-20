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
    final filterBuilder = ChoiceFilter.createBuilder<T>();
    final filterToggleBuilder = ChoiceFilterToggle.createBuilder<T>();
    return (selection, modal) {
      final filterable = modal.filterable;
      final filtering = modal.filter.displayed;
      final filter = filterBuilder(selection, modal);
      final effectiveTitle =
          title ?? (modal.title != null ? Text(modal.title!) : null);
      final actions = actionsBuilder
          ?.map((actionBuilder) => actionBuilder(selection, modal));
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
          if (filterable) filterToggleBuilder(selection, modal),
          if (!filtering) ...?actions,
        ],
      );
    };
  }
}
