import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/core/widgets/action_button.dart';
import 'package:go_router/go_router.dart';

class InfoDialog extends StatelessWidget {
  final List<String> message;
  final VoidCallback? onConfirm;

  const InfoDialog({super.key, required this.message, this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message[0],
              style: MyStyles.h1.copyWith(color: MyColors.yellow),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            Text(message[1], style: MyStyles.body, textAlign: TextAlign.center),
            const SizedBox(height: 20),

            ActionButton(
              onTap: () {
                context.pop();
              },
              title: 'OK',
            ),
          ],
        ),
      ),
    );
  }
}
