import 'package:flutter/material.dart';

class FoodVotingScreen extends StatelessWidget {
  final String eventId;

  const FoodVotingScreen({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Essensrichtung wählen'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Hier folgt die Auswahl der Essensrichtung.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}