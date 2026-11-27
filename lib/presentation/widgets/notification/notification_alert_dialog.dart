import 'package:board_gamer_app/notification/notification_util.dart';
import 'package:flutter/material.dart';

Future<void> notificationAlertDialog({
  required BuildContext context,
  required NotificationUtil notificationUtil,
}) {
  final textTheme = Theme.of(context).textTheme;

  return showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(
        "Zulassen von Benachrichtigungen?",
        style: textTheme.titleMedium,
        textAlign: .center,
      ),
      content: Text(
        "Board Game App brauch Berechtigungen um dich ueber Ereignisse auf dem Laufenden zu halten",
        style: textTheme.bodySmall,
        textAlign: .center,
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            Navigator.of(dialogContext).pop();
            notificationUtil.showNotificationConfigPage();
          },
          child: Text("Zulassen"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text("Nicht zulassen"),
        ),
      ],
    ),
  );
}
