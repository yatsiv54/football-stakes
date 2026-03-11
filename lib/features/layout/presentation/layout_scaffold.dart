import 'package:flutter/material.dart';
import 'package:football/features/layout/presentation/layout_navbar.dart';
import 'package:go_router/go_router.dart';

class LayoutScaffold extends StatefulWidget {
  const LayoutScaffold({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<LayoutScaffold> createState() => _LayoutScaffoldState();
}

class _LayoutScaffoldState extends State<LayoutScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: LayoutNavbar(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (value) => {
          widget.navigationShell.goBranch(
            value,
            initialLocation: value == widget.navigationShell.currentIndex,
          ),
        },
      ),
    );
  }
}
