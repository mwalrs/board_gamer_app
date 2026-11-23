class RatingSubmit {
  final String id;
  final String eventId;
  final String reviewerId;
  final double hostRating;
  final double foodRating;
  final double eveningRating;

  const RatingSubmit({
    required this.id,
    required this.eventId,
    required this.reviewerId,
    required this.hostRating,
    required this.foodRating,
    required this.eveningRating,
  });
}