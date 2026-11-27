import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:board_gamer_app/notification/notification_util.dart';
import 'package:flutter/material.dart';

import '../widgets/notification/notification_alert_dialog.dart';

class EventOverviewScreen extends StatefulWidget {
  const EventOverviewScreen({super.key});

  @override
  State<EventOverviewScreen> createState() => _EventOverviewScreenState();
}

class _EventOverviewScreenState extends State<EventOverviewScreen> {
  late final NotificationUtil _notificationUtil;

  @override
  void initState() {
    super.initState();

    _notificationUtil = NotificationUtil(
      awesomeNotifications: AwesomeNotifications(),
    );

    _checkNotificationPermission();
  }

  Future<void> _checkNotificationPermission() async {
    final isAllowed = await AwesomeNotifications().isNotificationAllowed();

    if (!mounted) return;

    if (!isAllowed) {
      await notificationAlertDialog(
        context: context,
        notificationUtil: _notificationUtil
      );
    }
  }

  @override
  void dispose() {
    AwesomeNotifications().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spieleabende',
          style: textTheme.titleLarge,
          textAlign: .left,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(padding: const EdgeInsets.all(20), child: Column()),
        ),
      ),
    );
  }
}
