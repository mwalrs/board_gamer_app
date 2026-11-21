import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/cuisine.dart';
import '../../domain/entities/food_vote.dart';

class FoodVoteModel extends FoodVote {
  const FoodVoteModel({
    required super.id,
    required super.cuisine,
    required super.votedAt,
  });

  factory FoodVoteModel.fromFirestore(Map<String, dynamic> data, String id) {
    final rawVotedAt = data['votedAt'];
    DateTime parsedDate;
    if (rawVotedAt is String) {
      parsedDate = DateTime.tryParse(rawVotedAt) ?? DateTime.now();
    } else if (rawVotedAt is Timestamp) {
      parsedDate = rawVotedAt.toDate();
    } else {
      parsedDate = DateTime.now();
    }

    return FoodVoteModel(
      id: id,
      cuisine: Cuisine.fromKey(data['cuisine'] as String?),
      votedAt: parsedDate,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'cuisine': cuisine.key,
      'votedAt': votedAt.toIso8601String(),
    };
  }
}