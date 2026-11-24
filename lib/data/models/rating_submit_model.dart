import 'package:board_gamer_app/domain/entities/rating_submit.dart';

class RatingSubmitModel extends RatingSubmit {
  const RatingSubmitModel({
    required super.id,
    required super.eventId,
    required super.reviewerId,
    required super.hostRating,
    required super.foodRating,
    required super.eveningRating,
  });

  factory RatingSubmitModel.fromFirestore(
      Map<String, dynamic> data,
      String id,
      ) {
    return RatingSubmitModel(
      id: id,
      eventId: data['eventId'] as String? ?? '',
      reviewerId: data['reviewerId'] as String? ?? '',
      hostRating: (data['ratingHost'] as num?)?.toDouble() ?? 0.0,
      foodRating: (data['ratingFood'] as num?)?.toDouble() ?? 0.0,
      eveningRating: (data['ratingEvening'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'eventId': eventId,
      'reviewerId': reviewerId,
      'ratingHost': hostRating,
      'ratingFood': foodRating,
      'ratingEvening': eveningRating,
    };
  }
}