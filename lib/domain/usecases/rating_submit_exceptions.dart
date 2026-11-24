class RatingSubmitException implements Exception {
  final String message;

  const RatingSubmitException([
    this.message = 'Die Bewertung konnte nicht gespeichert werden.',
  ]);

  @override
  String toString() => message;
}

class RatingAlreadySubmittedException implements Exception {
  final String message;

  const RatingAlreadySubmittedException([
    this.message = 'Du hast diesen Spielabend bereits bewertet.',
  ]);

  @override
  String toString() => message;
}

class InvalidRatingException implements Exception {
  final String message;

  const InvalidRatingException([
    this.message = 'Bitte bewerte alle drei Kategorien.',
  ]);

  @override
  String toString() => message;
}