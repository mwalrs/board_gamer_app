import '../entities/cuisine.dart';
import '../entities/food_vote.dart';
import '../entities/food_voting_result.dart';

class CalculateFoodVotingResultUseCase {
  FoodVotingResult execute(List<FoodVote> votes) {
    final counts = <Cuisine, int>{
      for (final cuisine in Cuisine.values) cuisine: 0,
    };

    for (final vote in votes) {
      counts[vote.cuisine] = (counts[vote.cuisine] ?? 0) + 1;
    }

    final totalVotes = votes.length;
    final percentages = <Cuisine, double>{};

    for (final cuisine in Cuisine.values) {
      final count = counts[cuisine] ?? 0;
      percentages[cuisine] =
      totalVotes == 0 ? 0.0 : (count / totalVotes) * 100.0;
    }

    int maxVotes = 0;
    for (final count in counts.values) {
      if (count > maxVotes) {
        maxVotes = count;
      }
    }
    
    // if tie, then all cuisine win with max. votes
    final winners = maxVotes == 0
        ? <Cuisine>[]
        : Cuisine.values
        .where((cuisine) => (counts[cuisine] ?? 0) == maxVotes)
        .toList();

    return FoodVotingResult(
      totalVotes: totalVotes,
      voteCounts: counts,
      percentages: percentages,
      winningCuisines: winners,
    );
  }
}