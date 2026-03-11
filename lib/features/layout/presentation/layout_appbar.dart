import 'package:flutter/material.dart';
import 'package:football/features/layout/presentation/widgets/date_title.dart';

class LayoutAppbar extends StatelessWidget implements PreferredSizeWidget {
  const LayoutAppbar({
    super.key,
    this.tittle,
    this.leading,
    this.actions,
    this.centerTittle,
    this.needDateWidget = false,
  });
  final Widget? tittle;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTittle;
  final bool needDateWidget;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        toolbarHeight: 60,
        centerTitle: centerTittle,
        leading: leading,
        title: needDateWidget ? DateTitle() : tittle,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
