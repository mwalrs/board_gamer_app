class CheckVotingDeadlineUseCase {
  static const Duration votingCutoffBeforeEvent = Duration(hours: 2);

  /// return 'true', when at least 120 mins left
  bool isVotingOpen({
    required DateTime eventDateTime,
    DateTime? now,
  }) {
    final currentTime = now ?? DateTime.now();
    final deadline = eventDateTime.subtract(votingCutoffBeforeEvent);
    return currentTime.isBefore(deadline);
  }

  /// Calculate time until end of voting (return 0 when over)
  Duration remainingVotingTime({
    required DateTime eventDateTime,
    DateTime? now,
  }) {
    final currentTime = now ?? DateTime.now();
    final deadline = eventDateTime.subtract(votingCutoffBeforeEvent);
    final diff = deadline.difference(currentTime);
    return diff.isNegative ? Duration.zero : diff;
  }

  /// Dashboard trigger for user:
  /// Show reminder while voting is active and user didn't vote yet
  bool shouldShowPlayerReminder({
    required DateTime eventDateTime,
    required bool hasUserVoted,
    DateTime? now,
  }) {
    if (hasUserVoted) return false;
    return isVotingOpen(eventDateTime: eventDateTime, now: now);
  }

  /// Notification trigger for host:
  /// Is active when 2h time limit is over and there is no restaurant applied (foodStatus == 'pending')
  bool shouldNotifyHostToSelectRestaurant({
    required DateTime eventDateTime,
    required String foodStatus,
    required bool isCurrentUserHost,
    DateTime? now,
  }) {
    if (!isCurrentUserHost) return false;
    if (foodStatus != 'pending') return false;
    return !isVotingOpen(eventDateTime: eventDateTime, now: now);
  }
}