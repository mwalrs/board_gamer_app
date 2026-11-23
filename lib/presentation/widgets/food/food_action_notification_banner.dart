import 'package:flutter/material.dart';
import '../../../domain/usecases/food_check_voting_deadline.dart';

class FoodActionNotificationBanner extends StatelessWidget {
  final DateTime eventDateTime;
  final String foodStatus;
  final bool isCurrentUserHost;
  final bool hasCurrentUserVoted;
  final VoidCallback? onOpenVoting;
  final VoidCallback? onOpenHostRestaurantSelection;

  const FoodActionNotificationBanner({
    super.key,
    required this.eventDateTime,
    required this.foodStatus,
    required this.isCurrentUserHost,
    required this.hasCurrentUserVoted,
    this.onOpenVoting,
    this.onOpenHostRestaurantSelection,
  });

  @override
  Widget build(BuildContext context) {
    final deadlineUseCase = CheckVotingDeadlineUseCase();
    final colorScheme = Theme.of(context).colorScheme;

    // Trigger for the host after the 2-hour time limit has expired
    final notifyHost = deadlineUseCase.shouldNotifyHostToSelectRestaurant(
      eventDateTime: eventDateTime,
      foodStatus: foodStatus,
      isCurrentUserHost: isCurrentUserHost,
    );

    if (notifyHost) {
      return Card(
        color: colorScheme.primaryContainer,
        child: ListTile(
          leading: Icon(Icons.notifications_active, color: colorScheme.onPrimaryContainer),
          title: Text(
            'Essens-Voting beendet',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          subtitle: Text(
            'Bitte wähle jetzt ein Restaurant basierend auf dem Ergebnis aus.',
            style: TextStyle(color: colorScheme.onPrimaryContainer),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onOpenHostRestaurantSelection,
        ),
      );
    }

    // Dashboard trigger for players who haven't voted yet
    final showPlayerReminder = deadlineUseCase.shouldShowPlayerReminder(
      eventDateTime: eventDateTime,
      hasUserVoted: hasCurrentUserVoted,
    );

    if (showPlayerReminder) {
      return Card(
        color: colorScheme.secondaryContainer,
        child: ListTile(
          leading: Icon(Icons.restaurant, color: colorScheme.onSecondaryContainer),
          title: Text(
            'Essensrichtung noch offen',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSecondaryContainer,
            ),
          ),
          subtitle: Text(
            'Stimme bis 2 Stunden vor Beginn für deine favorisierte Essensrichtung ab.',
            style: TextStyle(color: colorScheme.onSecondaryContainer),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onOpenVoting,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}