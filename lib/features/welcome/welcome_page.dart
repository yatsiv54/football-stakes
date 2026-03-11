import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/core/widgets/action_button.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HowItWorksDialog extends StatelessWidget {
  const HowItWorksDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 16, 16, 17),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: MyColors.grey2, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                style: MyStyles.h1.copyWith(fontStyle: FontStyle.italic),
                children: [
                  const TextSpan(text: 'HOW IT '),
                  TextSpan(
                    text: 'WORKS',
                    style: TextStyle(color: MyColors.yellow),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _buildStep(1, 'Pick a match and save your outcome.'),
            const SizedBox(height: 12),
            _buildStep(2, 'Add stake & confidence to build better stats'),
            const SizedBox(height: 12),
            _buildStep(3, 'Check results and improve your process'),
            const SizedBox(height: 24),
            ActionButton(onTap: () => Navigator.of(context).pop(), title: 'OK'),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int number, String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.grey1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$number',
            style: MyStyles.bodyBold.copyWith(color: MyColors.yellow),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: MyStyles.body.copyWith(height: 1.3)),
          ),
        ],
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  Future<void> _onStart(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_welcome', true);

    if (context.mounted) {
      context.go('/matches');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/icons/welcome.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'TRACK YOUR FOOTBALL PICKS — SMARTER',
                    textAlign: TextAlign.center,
                    style: MyStyles.h1.copyWith(fontSize: 28, height: 1.1),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Browse fixtures, save your picks with odds, and review performance over time.',
                    textAlign: TextAlign.center,
                    style: MyStyles.body.copyWith(
                      color: Colors.white.withOpacity(0.7),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  ActionButton(
                    onTap: () => _onStart(context),
                    title: "Let's Start",
                  ),

                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: const Color(0xFF505050).withOpacity(0.6),
                        builder: (context) => const HowItWorksDialog(),
                      );
                    },
                    child: Text(
                      'How it works',
                      style: MyStyles.body.copyWith(
                        color: Colors.white.withOpacity(0.5),
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
