import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';

enum Outcome { home, draw, away }

class OutcomeSelector extends StatefulWidget {
  final Outcome? selectedOutcome;
  final ValueChanged<Outcome>? onChanged;
  final bool enabled;

  const OutcomeSelector({
    super.key,
    this.selectedOutcome,
    this.onChanged,
    this.enabled = true,

  });

  @override
  State<OutcomeSelector> createState() => _OutcomeSelectorState();
}

class _OutcomeSelectorState extends State<OutcomeSelector> {
  Outcome? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedOutcome;
  }

  void _onSelect(Outcome outcome) {
    if (!widget.enabled) return;

    setState(() {
      _selected = outcome;
    });

    widget.onChanged?.call(outcome);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _OutcomeButton(
                label: 'Home',
                isSelected: _selected == Outcome.home,
                onTap: () => _onSelect(Outcome.home),
                enabled: widget.enabled,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _OutcomeButton(
                label: 'Draw',
                isSelected: _selected == Outcome.draw,
                onTap: () => _onSelect(Outcome.draw),
                enabled: widget.enabled,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _OutcomeButton(
                label: 'Away',
                isSelected: _selected == Outcome.away,
                onTap: () => _onSelect(Outcome.away),
                enabled: widget.enabled,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OutcomeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool enabled;

  const _OutcomeButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 56,
        decoration: BoxDecoration(
          color: MyColors.grey2,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? MyColors.yellow : Colors.transparent,
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
