import 'package:board_gamer_app/presentation/widgets/rating/rating_display_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('RatingDisplay', () {
    testWidgets('displays review count', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: RatingDisplayWidget(
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
          home: RatingDisplayWidget(
            averageRating: 0,
            reviewCount: 0,
          ),
        ),
      );

      expect(find.text('(?)'), findsOneWidget);
    });
  });
}