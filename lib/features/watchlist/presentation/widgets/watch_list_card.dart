import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/core/services/notification_service.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/matches/data/entities/match/match_entity.dart';
import 'package:football/features/matches/presentation/cubit/matches_cubit.dart';
import 'package:football/features/matches/presentation/widgets/result_widget.dart';
import 'package:football/features/matches/presentation/widgets/upcoming_widget.dart';
import 'package:football/features/watchlist/presentation/cubit/watchlist_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class WatchListCard extends StatelessWidget {
  final MatchEntity match;
  const WatchListCard({super.key, required this.match});

  DateTime _getFullDate() {
    DateTime date = match.date;
    int hour = 0;
    int minute = 0;
    try {
      final parts = match.time.split(':');
      if (parts.length == 2) {
        hour = int.parse(parts[0]);
        minute = int.parse(parts[1]);
      }
    } catch (_) {}

    return DateTime.utc(
      date.year,
      date.month,
      date.day,
      hour,
      minute,
    ).toLocal();
  }

  bool _isTooLate() {
    if (match.status != 'Upcoming') return true;
    final kickOff = _getFullDate();
    final reminderTime = kickOff.subtract(const Duration(minutes: 15));
    return DateTime.now().isAfter(reminderTime);
  }

  Future<void> _handleNotificationToggle(
    BuildContext context,
    MatchesCubit cubit,
  ) async {
    final result = await cubit.toggleNotification(
      matchId: match.id,
      matchTitle: '${match.homeTeam.name} vs ${match.awayTeam.name}',
      matchTime: _getFullDate(),
    );

    if (!context.mounted) return;

    switch (result) {
      case NotificationResult.successScheduled:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reminder set for 15 min before match')),
        );
        break;
      case NotificationResult.successRemoved:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Reminder removed')));
        break;
      case NotificationResult.errorDisabledInSettings:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kickoff reminders are disabled in Settings'),
          ),
        );
        break;
      case NotificationResult.errorPermissionsRequired:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Notifications permission needed'),
            action: SnackBarAction(
              label: 'Settings',
              onPressed: () => NotificationService().openSettings(),
            ),
          ),
        );
        break;
      case NotificationResult.errorTooLate:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Too late to set a reminder (start < 15 min)'),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final watchlistCubit = context.read<WatchlistCubit>();
    final matchesCubit = GetIt.I<MatchesCubit>();

    final bool isLive = _isLive(match.status);
    final bool tooLate = _isTooLate();

    return InkWell(
      onTap: () => context.push('/matches/details', extra: match),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: MyColors.grey2,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  ClipOval(child: _buildNetworkImage(match.leagueLogo, 24)),
                  const SizedBox(width: 8),
                  Expanded(child: Text(match.league, style: MyStyles.medium)),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: MyColors.grey1),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: MyStyles.medium,
                          children: isLive
                              ? [
                                  TextSpan(
                                    text: 'LIVE',
                                    style: MyStyles.medium.copyWith(
                                      color: Colors.red,
                                    ),
                                  ),
                                  const TextSpan(text: ' | '),
                                  TextSpan(
                                    text: RegExp(r'^\d').hasMatch(match.status)
                                        ? '${match.status}\''
                                        : match.status,
                                    style: MyStyles.medium.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                                  ),
                                ]
                              : [
                                  TextSpan(
                                    text: _isFinished(match.status)
                                        ? 'Finished'
                                        : 'Upcoming',
                                    style: MyStyles.medium.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' | ',
                                    style: MyStyles.medium.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: match.time,
                                    style: MyStyles.medium.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                                  ),
                                ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        watchlistCubit.toggleMatch(match);
                      },
                      child: Icon(Icons.star, color: MyColors.yellow, size: 25),
                    ),
                    const SizedBox(width: 16),
                    StreamBuilder<List<String>>(
                      stream: matchesCubit.notificationsStream,
                      initialData: matchesCubit.notifiedMatchIds,
                      builder: (context, snapshot) {
                        final notifiedIds = snapshot.data ?? [];
                        final isNotified = notifiedIds.contains(match.id);

                        return GestureDetector(
                          onTap: (tooLate && !isNotified)
                              ? null
                              : () => _handleNotificationToggle(
                                  context,
                                  matchesCubit,
                                ),
                          child: isNotified
                              ? Image.asset(
                                  'assets/images/icons/remind2.png',
                                  scale: 2.3,
                                )
                              : Image.asset(
                                  'assets/images/icons/remind1.png',
                                  scale: 2.3,
                                  color: tooLate
                                      ? Colors.grey.shade800
                                      : MyColors.yellow,
                                ),
                          // child: Icon(
                          //   isNotified
                          //       ? Icons.notifications_active
                          //       : Icons.notifications_none,
                          //   color: (tooLate && !isNotified)
                          //       ? Colors.grey.withOpacity(0.2)
                          //       : MyColors.yellow,
                          //   size: 24,
                          // ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: MyColors.grey3,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 32,
                                child: _buildNetworkImage(
                                  match.homeTeam.logo,
                                  32,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  match.homeTeam.name,
                                  style: MyStyles.bodyBold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              SizedBox(
                                width: 32,
                                child: _buildNetworkImage(
                                  match.awayTeam.logo,
                                  32,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  match.awayTeam.name,
                                  style: MyStyles.bodyBold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    match.status == 'Upcoming'
                        ? const UpcomingWidget()
                        : ResultWidget(match: match),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkImage(String url, double size) {
    if (url.isEmpty) {
      return Container(
        width: size,
        height: size,
        color: Colors.grey.withOpacity(0.3),
        child: Icon(Icons.shield, size: size * 0.6, color: Colors.white54),
      );
    }
    return Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        width: size,
        height: size,
        color: Colors.grey.withOpacity(0.3),
        child: Icon(
          Icons.error_outline,
          size: size * 0.6,
          color: Colors.white54,
        ),
      ),
    );
  }
}

bool _isLive(String status) {
  if (['Half Time', 'HT', 'Break', 'Penalty In Progress'].contains(status)) {
    return true;
  }
  return RegExp(r'^\d+(\+\d*)?$').hasMatch(status);
}

bool _isFinished(String status) {
  return status == 'Finished' ||
      status == 'FT' ||
      status == 'AET' ||
      status == 'PEN';
}
