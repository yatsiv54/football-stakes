import 'package:flutter/material.dart';
import 'package:football/core/di/di.dart';
import 'package:football/core/router/router.dart';
import 'package:football/core/services/notification_service.dart';
import 'package:football/core/theme/theme.dart';
import 'package:football/features/picks/presentation/cubit/picks_cubit.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  loadDependencies();

  await NotificationService().init();

  GetIt.I<PicksCubit>().loadPicks();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp.router(

        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
      ),
    );
  }
}
