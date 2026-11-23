import 'package:flutter/material.dart';
import 'rating/rating_display_widget.dart';

class AverageRatingsDisplay extends StatelessWidget {
  final double averageHost;
  final int hostReviewCount;

  final double averageFood;
  final int foodReviewCount;

  final double averageEvening;
  final int eveningReviewCount;

  const AverageRatingsDisplay({
    super.key,
    required this.averageHost,
    required this.hostReviewCount,
    required this.averageFood,
    required this.foodReviewCount,
    required this.averageEvening,
    required this.eveningReviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Nachfolgend werden die Durchschnittsbewertungen angezeigt, auf 0.5 gerundet.',
        ),
        const SizedBox(height: 16),

        Column(
          children: [
            Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 6),
                const Text('Gastgeber'),
              ]
            ),
            RatingDisplayWidget(
              averageRating: averageHost,
              reviewCount: hostReviewCount,
            ),
          ],
        ),

        const SizedBox(height: 16),

        Column(
          children: [
            Row(
              children: [
                const Icon(Icons.restaurant),
                const SizedBox(width: 6),
                const Text('Essen'),
              ]
            ),
            Row(
              children: [
                RatingDisplayWidget(
                  averageRating: averageFood,
                  reviewCount: foodReviewCount,
                ),
              ]
            ),
          ],
        ),

        const SizedBox(height: 16),

        Column(
          children: [
            Row(
              children: [
                const Icon(Icons.nightlight),
                const SizedBox(width: 6),
                const Text('Abend'),
              ]
            ),
            Row(
              children: [
                RatingDisplayWidget(
                  averageRating: averageEvening,
                  reviewCount: eveningReviewCount,
                ),
              ]
            ),
          ],
        ),
      ],
    );
  }
}