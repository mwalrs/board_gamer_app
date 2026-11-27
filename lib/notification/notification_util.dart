

import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationUtil {
  final AwesomeNotifications awesomeNotifications;

  NotificationUtil({required this.awesomeNotifications});

  void showNotificationConfigPage() {
    AwesomeNotifications().showNotificationConfigPage();
  }
}