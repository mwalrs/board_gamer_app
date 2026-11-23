import 'package:board_gamer_app/domain/usecases/rating_submit_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar_plus/flutter_rating_bar_plus.dart';
import 'package:uuid/uuid.dart';

import 'package:board_gamer_app/themes/colors.dart';
import 'package:board_gamer_app/domain/entities/rating_submit.dart';
import 'package:board_gamer_app/domain/usecases/rating_submit_exceptions.dart';

class RatingSubmitWidget extends StatefulWidget {
  const RatingSubmitWidget({
    required this.eventId,
    required this.reviewerId,
    required this.submitRatingUseCase,
    super.key,
  });

  final String eventId;
  final String reviewerId;
  final RatingSubmitUseCase submitRatingUseCase;

  @override
  State<RatingSubmitWidget> createState() => _RatingSubmitWidgetState();
}

class _RatingSubmitWidgetState extends State<RatingSubmitWidget> {
  double ratingHost = 0;
  double ratingFood = 0;
  double ratingEvening = 0;

  bool _isSaving = false;

  Future<void> _saveRating() async {
    setState(() => _isSaving = true);

    final rating = RatingSubmit(
      id: const Uuid().v4(),
      eventId: widget.eventId,
      reviewerId: widget.reviewerId,
      hostRating: ratingHost,
      foodRating: ratingFood,
      eveningRating: ratingEvening,
    );

    try {
      await widget.submitRatingUseCase.execute(
        rating: rating,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bewertung erfolgreich gespeichert!'),
        ),
      );
    } on InvalidRatingException catch (e) {
      if (!mounted) return;
      _showMessage(e.toString());
    } on RatingSubmitException catch (e) {
      if (!mounted) return;
      _showMessage(e.toString());
    } catch (e) {
      if (!mounted) return;
      _showMessage('Ein unerwarteter Fehler ist aufgetreten.');
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            'Wie bewertest du den Spielabend?',
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),

        _buildRatingCard(
          title: 'Gastgeber',
          rating: ratingHost,
          onRatingUpdate: (value) {
            setState(() => ratingHost = value);
          },
        ),

        _buildRatingCard(
          title: 'Essen',
          rating: ratingFood,
          onRatingUpdate: (value) {
            setState(() => ratingFood = value);
          },
        ),

        _buildRatingCard(
          title: 'Gesamtabend',
          rating: ratingEvening,
          onRatingUpdate: (value) {
            setState(() => ratingEvening = value);
          },
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton(
            onPressed: _isSaving ? null : _saveRating,
            style: ElevatedButton.styleFrom(
              backgroundColor: BoardGameColors.accent500,
              foregroundColor: BoardGameColors.buttonLabel,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: _isSaving
                ? const CircularProgressIndicator()
                : const Text(
              'Speichern',
              style: TextStyle(
                fontFamily: 'Archivo',
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingCard({
    required String title,
    required double rating,
    required ValueChanged<double> onRatingUpdate,
  }) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 16),
            RatingBar.builder(
              initialRating: rating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 36,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: BoardGameColors.ratedStars,
              ),
              onRatingUpdate: onRatingUpdate,
            ),
          ],
        ),
      ),
    );
  }
}