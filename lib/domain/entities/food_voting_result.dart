import 'cuisine.dart';

class FoodVotingResult {
  final int totalVotes;
  final Map<Cuisine, int> voteCounts;
  final Map<Cuisine, double> percentages;
  final List<Cuisine> winningCuisines;

  const FoodVotingResult({
    required this.totalVotes,
    required this.voteCounts,
    required this.percentages,
    required this.winningCuisines,
  });

  bool get hasTie => winningCuisines.length > 1;
}