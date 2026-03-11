import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';

class RemindMeWidget extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const RemindMeWidget({
    super.key,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  State<RemindMeWidget> createState() => _RemindMeWidgetState();
}

class _RemindMeWidgetState extends State<RemindMeWidget> {
  late bool _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E), 
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Remind me 15 min before kickoff',
            style: MyStyles.bodyBold.copyWith(
              color: Colors.white,
              fontSize: 15, 
            ),
          ),
          Transform.scale(
            scale: 0.9, 
            child: CupertinoSwitch(
              value: _currentValue,
              activeColor: MyColors.yellow, 
              trackColor: Colors.grey.withOpacity(0.3), 
              thumbColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                });
                widget.onChanged(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}