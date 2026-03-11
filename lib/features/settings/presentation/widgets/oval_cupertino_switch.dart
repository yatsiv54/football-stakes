import 'package:flutter/material.dart';

class OvalCupertinoSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color trackColor;
  final Color thumbColor;

  const OvalCupertinoSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.activeColor,
    required this.trackColor,
    required this.thumbColor,
  });

  @override
  State<OvalCupertinoSwitch> createState() => _OvalCupertinoSwitchState();
}

class _OvalCupertinoSwitchState extends State<OvalCupertinoSwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      value: widget.value ? 1 : 0,
    );
  }

  @override
  void didUpdateWidget(covariant OvalCupertinoSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.value ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, _) {
          final t = _controller.value;

          return Container(
            width: 58,
            height: 28,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Color.lerp(widget.trackColor, widget.activeColor, t),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Align(
              alignment: Alignment.lerp(
                Alignment.centerLeft,
                Alignment.centerRight,
                t,
              )!,
              child: Container(
                width: 32,
                height: 24,
                decoration: BoxDecoration(
                  color: widget.thumbColor,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
