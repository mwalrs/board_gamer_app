import 'package:board_gamer_app/domain/entities/rating_display.dart';

class RatingDisplayModel extends RatingDisplay {
  const RatingDisplayModel({
    required super.id,
    required super.hostRating,
    required super.foodRating,
    required super.eveningRating,
  });

  factory RatingDisplayModel.fromFirestore(
      Map<String, dynamic> data,
      String id,
      ) {
    return RatingDisplayModel(
      id: id,
      hostRating: (data['hostRating'] as num?)?.toDouble() ?? 0.0,
      foodRating: (data['foodRating'] as num?)?.toDouble() ?? 0.0,
      eveningRating: (data['eveningRating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}