import 'package:board_gamer_app/domain/usecases/rating_submit_usecase.dart';
import 'package:board_gamer_app/presentation/widgets/rating/rating_submit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:board_gamer_app/domain/entities/rating_submit.dart';
import 'package:board_gamer_app/domain/repositories/rating_repository.dart';

class FakeRatingRepository implements RatingRepository {
  bool wasCalled = false;

  @override
  Future<void> saveRating(RatingSubmit rating) async {
    wasCalled = true;
  }
}

void main() {
  late FakeRatingRepository repository;
  late RatingSubmitUseCase useCase;

  setUp(() {
    repository = FakeRatingRepository();
    useCase = RatingSubmitUseCase(repository);
  });

  Widget createWidget() {
    return MaterialApp(
      home: Scaffold(
        body: RatingSubmitWidget(
          eventId: 'event-123',
          reviewerId: 'user-123',
          submitRatingUseCase: useCase,
        ),
      ),
    );
  }

  group('RatingSubmitWidget', () {
    testWidgets('soll das Bewertungsformular anzeigen', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('Speichern'), findsOneWidget);
    });

    testWidgets('soll eine ungültige Bewertung ablehnen', (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.tap(find.text('Speichern'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(
        find.text('Bitte bewerte alle drei Kategorien.'),
        findsOneWidget,
      );

      expect(repository.wasCalled, isFalse);
    });
  });
}