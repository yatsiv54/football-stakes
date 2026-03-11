import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';

class ClearDataDialog extends StatelessWidget {
  final String title;

  const ClearDataDialog({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 20, 20, 20),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: MyColors.grey2, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: MyStyles.h1.copyWith(
                color: MyColors.yellow,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: _DialogButton(
                    title: 'Cancel',
                    isPrimary: false,
                    onTap: () => Navigator.of(context).pop(false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DialogButton(
                    title: 'Clear',
                    isPrimary: true,
                    onTap: () => Navigator.of(context).pop(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  final String title;
  final bool isPrimary;
  final VoidCallback onTap;

  const _DialogButton({
    required this.title,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isPrimary ? MyColors.yellow : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: MyColors.yellow, width: 1),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: MyStyles.bodyBold.copyWith(
            color: isPrimary ? Colors.black : MyColors.yellow,
          ),
        ),
      ),
    );
  }
}
