import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:board_gamer_app/ui/core/rating_display.dart';

void main() {
  group('RatingDisplay', () {
    testWidgets('displays review count', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RatingDisplay(
            averageRating: 4.5,
            reviewCount: 120,
          ),
        ),
      );

      expect(find.text('(120)'), findsOneWidget);
    });

    testWidgets('displays ? when there are no reviews', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RatingDisplay(
            averageRating: 0,
            reviewCount: 0,
          ),
        ),
      );

      expect(find.text('(?)'), findsOneWidget);
    });
  });
}