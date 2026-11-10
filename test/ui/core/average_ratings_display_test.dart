import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:board_gamer_app/ui/core/average_ratings_display.dart';
import 'package:board_gamer_app/ui/core/rating_display.dart';

void main() {
  late List<RatingDisplay> ratings;

  Future<void> setupWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AverageRatingsDisplay(
            averageHost: 4.5,
            hostReviewCount: 12,
            averageFood: 4.0,
            foodReviewCount: 10,
            averageEvening: 3.5,
            eveningReviewCount: 8,
          ),
        ),
      ),
    );

    ratings = tester.widgetList<RatingDisplay>(
      find.byType(RatingDisplay),
    ).toList();
  }

  group('AverageRatingsDisplay', () {
    testWidgets('Host rating displays correct values',
            (WidgetTester tester) async {
          await setupWidget(tester);

          expect(ratings[0].averageRating, 4.5);
          expect(ratings[0].reviewCount, 12);
        });

    testWidgets('Food rating displays correct values',
            (WidgetTester tester) async {
          await setupWidget(tester);

          expect(ratings[1].averageRating, 4.0);
          expect(ratings[1].reviewCount, 10);
        });

    testWidgets('Evening rating displays correct values',
            (WidgetTester tester) async {
          await setupWidget(tester);

          expect(ratings[2].averageRating, 3.5);
          expect(ratings[2].reviewCount, 8);
        });
  });
}