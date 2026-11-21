import 'package:flutter/material.dart';

class VotingReminderBanner extends StatelessWidget {
  final String hostName;
  final String? deadlineText;

  const VotingReminderBanner({
    super.key,
    required this.hostName,
    this.deadlineText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.access_time,
              color: colorScheme.onSecondaryContainer,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Erinnerung: Voting-Frist',
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    deadlineText != null
                        ? 'Bitte stimme bis $deadlineText (2 Stunden vor Beginn) ab, damit Gastgeber $hostName das Restaurant festlegen kann.'
                        : 'Bitte stimme bis spätestens 2 Stunden vor Beginn ab, damit Gastgeber $hostName das Restaurant festlegen kann.',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}