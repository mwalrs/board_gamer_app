import 'package:flutter/material.dart';
import '../../../domain/entities/cuisine.dart';
import '../../../domain/entities/food_voting_result.dart';
import '../../../themes/colors.dart';

class VotingResultProgressCard extends StatelessWidget {
  final FoodVotingResult votingResult;

  const VotingResultProgressCard({
    super.key,
    required this.votingResult,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    // Filter categories with > 0 votes and sort in descending order so winners appear at top
    final sortedCuisines = List<Cuisine>.from(Cuisine.values)
      .where((cuisine) => (votingResult.voteCounts[cuisine] ?? 0) > 0)
      .toList()
      ..sort((a, b) {
        final countA = votingResult.voteCounts[a] ?? 0;
        final countB = votingResult.voteCounts[b] ?? 0;
        return countB.compareTo(countA);
      });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Voting-Ergebnis',
                  style: textTheme.labelMedium,
                ),
                Text(
                  '${votingResult.totalVotes} ${votingResult.totalVotes == 1 ? 'Stimme' : 'Stimmen'}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: BoardGameColors.muted,
                  ),
                ),
              ],
            ),
            if (votingResult.hasTie) ...[
              const SizedBox(height: 6),
              Text(
                'Stimmengleichstand – mehrere Favoriten liegen vorne:',
                style: textTheme.bodyMedium?.copyWith(
                  color: BoardGameColors.accent700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 16),
            if (votingResult.totalVotes == 0)
              Text(
                'Es wurden noch keine Stimmen abgegeben.',
                style: textTheme.bodyMedium,
              )
            else
              ...sortedCuisines.map((cuisine) {
                final count = votingResult.voteCounts[cuisine] ?? 0;
                final percentage = votingResult.percentages[cuisine] ?? 0.0;
                final isWinner = votingResult.winningCuisines.contains(cuisine);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${cuisine.icon} ',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Expanded(
                            child: Text(
                              isWinner
                                  ? '${cuisine.displayName} (Favorit)'
                                  : cuisine.displayName,
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: isWinner
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                                color: isWinner
                                    ? BoardGameColors.accent700
                                    : BoardGameColors.defaultText,
                              ),
                            ),
                          ),
                          Text(
                            '${percentage.round()}% ($count)',
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: isWinner
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: isWinner
                                  ? BoardGameColors.accent700
                                  : BoardGameColors.muted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(
                        value: (percentage / 100.0).clamp(0.0, 1.0),
                        minHeight: 8,
                        backgroundColor: BoardGameColors.formColor,
                        color: isWinner
                            ? BoardGameColors.accent500
                            : BoardGameColors.muted,
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}