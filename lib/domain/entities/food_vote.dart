import 'cuisine.dart';

class FoodVote {
  final String id;  // ID of the user
  final Cuisine cuisine;
  final DateTime votedAt;

  const FoodVote({
    required this.id,
    required this.cuisine,
    required this.votedAt,
  });
}