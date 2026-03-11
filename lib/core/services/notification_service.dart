import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'football_channel',
        channelName: 'Football Matches',
        channelDescription: 'Notifications for upcoming matches',
        defaultColor: const Color(0xFFFFBC03),
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        playSound: true,
        enableVibration: true,
        defaultRingtoneType: DefaultRingtoneType.Notification,
      ),
    ], debug: true);

    _isInitialized = true;
    debugPrint('[NOTIF] ✅ Awesome Notifications initialized');
  }

  Future<bool> ensurePermissions() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();

    if (!isAllowed) {
      isAllowed = await AwesomeNotifications()
          .requestPermissionToSendNotifications();
    }

    List<NotificationPermission> permissionsNeeded = [
      NotificationPermission.Alert,
      NotificationPermission.Sound,
      NotificationPermission.Badge,
      NotificationPermission.Vibration,
      NotificationPermission.PreciseAlarms,
    ];

    final permissionsAllowed = await AwesomeNotifications().checkPermissionList(
      channelKey: 'football_channel',
      permissions: permissionsNeeded,
    );

    if (!permissionsAllowed.contains(NotificationPermission.PreciseAlarms)) {
      await AwesomeNotifications().requestPermissionToSendNotifications(
        permissions: [NotificationPermission.PreciseAlarms],
      );
    }

    return isAllowed;
  }

  Future<bool> scheduleMatchReminder({
    required String pickId,
    required String matchTitle,
    required DateTime matchTime,
  }) async {
    await NotificationService().ensurePermissions();
    final reminderTime = matchTime.subtract(const Duration(minutes: 15));
    final now = DateTime.now();

    if (reminderTime.isBefore(now)) {
      debugPrint('[NOTIF] ❌ Too late for: $matchTitle');
      return false;
    }

    debugPrint('[NOTIF] Scheduling: $matchTitle for $reminderTime');

    try {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: pickId.hashCode,
          channelKey: 'football_channel',
          title: 'Match Reminder ⚽️',
          body: '$matchTitle starts in 15 minutes!',
          notificationLayout: NotificationLayout.Default,
          wakeUpScreen: true,
          category: NotificationCategory.Reminder,
        ),
        schedule: NotificationCalendar.fromDate(
          date: reminderTime,
          preciseAlarm: true,
        ),
      );

      debugPrint('[NOTIF] ✅ Scheduled successfully');
      return true;
    } catch (e) {
      debugPrint('[NOTIF] ❌ Error scheduling: $e');
      return false;
    }
  }

  Future<void> cancelReminder(String pickId) async {
    await AwesomeNotifications().cancel(pickId.hashCode);
    debugPrint('[NOTIF] Cancelled: $pickId');
  }

  Future<void> showInstantNotification() async {
    debugPrint('[NOTIF] Sending instant notification...');

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 999,
        channelKey: 'football_channel',
        title: 'Test Notification 🔔',
        body: 'Notifications are working correctly!',
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: true,
      ),
    );
  }

  Future<void> schedule10SecondsTest(String matchName) async {
    final now = DateTime.now();
    final scheduledTime = now.add(const Duration(seconds: 10));

    try {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 888,
          channelKey: 'football_channel',
          title: '10s Test ⏱️',
          body: '10 seconds passed! Match: $matchName',
          notificationLayout: NotificationLayout.Default,
          wakeUpScreen: true,
          category: NotificationCategory.Alarm,
          autoDismissible: false,
        ),
        schedule: NotificationCalendar.fromDate(
          date: scheduledTime,
          preciseAlarm: true,
        ),
      );
    } catch (e) {
      debugPrint('[NOTIF] ❌ Error: $e');
    }
  }

  Future<void> openSettings() async {
    await AwesomeNotifications().showNotificationConfigPage();
  }
}
