import 'package:flutter/material.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _navigate();
  }

  Future<void> _navigate() async {
    final minDelay = Future.delayed(const Duration(seconds: 2));
    final prefsFuture = SharedPreferences.getInstance();

    final results = await Future.wait([minDelay, prefsFuture]);
    final prefs = results[1] as SharedPreferences;

    final bool seenWelcome = prefs.getBool('seen_welcome') ?? false;

    if (mounted) {
      if (seenWelcome) {
        context.go('/matches');
      } else {
        context.go('/welcome');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                RotationTransition(
                  turns: _controller,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset('assets/images/icons/spinner.png'),
                  ),
                ),
                SizedBox(height: 20),
                Text('LOADING...', style: MyStyles.body),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
