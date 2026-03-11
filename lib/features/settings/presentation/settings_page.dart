import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/layout/presentation/layout_appbar.dart';
import 'package:football/features/matches/data/repositories/matches_repository.dart';
import 'package:football/features/matches/presentation/cubit/matches_cubit.dart';
import 'package:football/features/picks/presentation/cubit/picks_cubit.dart';
import 'package:football/features/settings/presentation/widgets/clear_data_dialog.dart';
import 'package:football/features/settings/presentation/widgets/oval_cupertino_switch.dart';
import 'package:football/features/watchlist/presentation/cubit/watchlist_cubit.dart';
import 'package:get_it/get_it.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _kickoffReminders = true;
  final MatchesRepository _repo = GetIt.I<MatchesRepository>();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final val = await _repo.getKickoffReminder();
    setState(() {
      _kickoffReminders = val;
    });
  }

  Future<void> _toggleReminders(bool value) async {
    setState(() {
      _kickoffReminders = value;
    });

    await GetIt.I<MatchesCubit>().setKickoffReminders(value);
  }

  Future<void> _openSystemSettings() async {
    await AppSettings.openAppSettings(type: AppSettingsType.notification);
  }

  Future<void> _clearAllPicks() async {
    final confirm = await showDialog<bool>(
      context: context,
      barrierColor: const Color(0xFF505050).withOpacity(0.6),
      builder: (context) => const ClearDataDialog(title: 'CLEAR ALL PICKS?'),
    );

    if (confirm == true && mounted) {
      await context.read<PicksCubit>().deleteAllPicks();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("All picks cleared"),
          backgroundColor: MyColors.yellow,
        ),
      );
    }
  }

  Future<void> _clearWatchlist() async {
    final confirm = await showDialog<bool>(
      context: context,
      barrierColor: const Color(0xFF505050).withOpacity(0.6),
      builder: (context) => const ClearDataDialog(title: 'CLEAR WATCHLIST?'),
    );

    if (confirm == true && mounted) {
      GetIt.I<WatchlistCubit>().clearWatchlist();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Watchlist cleared"),
          backgroundColor: MyColors.yellow,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: GetIt.I<PicksCubit>()),
        BlocProvider.value(value: GetIt.I<MatchesCubit>()),
      ],
      child: Scaffold(
        appBar: LayoutAppbar(
          tittle: Text(
            'SETTINGS',
            style: MyStyles.h1.copyWith(color: MyColors.yellow),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      color: MyColors.grey2,
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(16),
                      child: Text('Notifications', style: MyStyles.h2),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(8),
                      ),
                      color: MyColors.grey3,
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(16),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: MyColors.grey1,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Kickoff reminders',
                                  style: MyStyles.bodyBold,
                                ),
                                Transform.scale(
                                  scale: 1,
                                  child: OvalCupertinoSwitch(
                                    value: _kickoffReminders,
                                    activeColor: MyColors.yellow,
                                    trackColor: Colors.grey.withOpacity(0.3),
                                    thumbColor: Colors.white,
                                    onChanged: _toggleReminders,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          GestureDetector(
                            onTap: _openSystemSettings,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Notification Settings',
                                  style: MyStyles.bodyBold.copyWith(
                                    color: MyColors.yellow,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 20,
                                  color: MyColors.yellow,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  color: MyColors.grey2,
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: Text('Data', style: MyStyles.h2),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                  color: MyColors.grey3,
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.grey1,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _ActionTextTile(
                          title: 'Clear all picks',
                          icon: 'assets/images/icons/delete.png',
                          iconColor: MyColors.red,
                          textColor: Colors.white,
                          onTap: _clearAllPicks,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.grey1,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _ActionTextTile(
                          title: 'Clear watchlist',
                          icon: 'assets/images/icons/delete.png',
                          iconColor: MyColors.red,
                          textColor: Colors.white,
                          onTap: _clearWatchlist,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  color: MyColors.grey2,
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: Text('About', style: MyStyles.h2),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                  color: MyColors.grey3,
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.grey1,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/icons/info.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 8),
                              Text('App Version', style: MyStyles.bodyBold),
                              Spacer(),
                              Text('1.0.0', style: MyStyles.h3),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'This app is for tracking and analysis only.\nNo real betting or gambling functionality.',
                        textAlign: TextAlign.center,
                        style: MyStyles.body,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionTextTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color textColor;
  final String? icon;
  final Color? iconColor;
  final bool showArrow;

  const _ActionTextTile({
    required this.title,
    required this.onTap,
    required this.textColor,
    this.icon,
    this.iconColor,
    // ignore: unused_element_parameter
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            if (icon != null) ...[
              Image.asset(icon!, width: 24, height: 24, color: iconColor),
              const SizedBox(width: 12),
            ],
            Expanded(child: Text(title, style: MyStyles.bodyBold)),
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: MyColors.yellow,
              ),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_element
class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: MyColors.grey1,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: MyColors.yellow, size: 20),
            const SizedBox(width: 12),
            Text(title, style: MyStyles.bodyBold),
            const Spacer(),
            Text(
              value,
              style: MyStyles.body.copyWith(
                color: Colors.white.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
