import '../../data/models/rating.dart';

class RatingModel extends Rating {
  const RatingModel({
    required super.id,
    required super.hostRating,
    required super.foodRating,
    required super.eveningRating,
  });

  factory RatingModel.fromFirestore(
      Map<String, dynamic> data,
      String id,
      ) {
    return RatingModel(
      id: id,
      hostRating: (data['hostRating'] as num?)?.toDouble() ?? 0.0,
      foodRating: (data['foodRating'] as num?)?.toDouble() ?? 0.0,
      eveningRating: (data['eveningRating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
