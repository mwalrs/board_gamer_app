import 'package:flutter/material.dart';
import 'package:flutter_rating_bar_plus/flutter_rating_bar_plus.dart';
import 'package:board_gamer_app/themes/colors.dart';

class RatingDisplayWidget extends StatelessWidget {
  const RatingDisplayWidget({
    required this.averageRating,
    required this.reviewCount,
    super.key,
  });

  final double averageRating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(
          averageRating.toStringAsFixed(1),
          style: textTheme.labelMedium,
        ),
        const SizedBox(width: 6),
        RatingBar.builder(
          initialRating: averageRating,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 20,
          ignoreGestures: true,
          itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: BoardGameColors.ratedStars,
          ),
          onRatingUpdate: (_) {},
        ),
        const SizedBox(width: 6),
        Text(
          '(${reviewCount == 0 ? '?' : reviewCount})',
          style: textTheme.bodyMedium?.copyWith(
            color: BoardGameColors.muted,
          ),
        ),
      ],
    );
  }
}
