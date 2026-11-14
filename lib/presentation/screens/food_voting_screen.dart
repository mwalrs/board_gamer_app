import 'package:flutter/material.dart';
import '../../domain/entities/cuisine.dart';
import '../widgets/food/cuisine_radio_list.dart';
import '../widgets/food/voting_reminder_banner.dart';

class FoodVotingScreen extends StatefulWidget {
  final String eventId;
  final String hostName;
  final String? deadlineText;
  final bool isVotingOpen;

  const FoodVotingScreen({
    super.key,
    required this.eventId,
    this.hostName = 'Gastgeber',
    this.deadlineText,
    this.isVotingOpen = true,
  });

  @override
  State<FoodVotingScreen> createState() => _FoodVotingScreenState();
}

class _FoodVotingScreenState extends State<FoodVotingScreen> {
  Cuisine? _selectedCuisine;

  void _onSavePressed() {
    if (_selectedCuisine == null) return;

    // Platzhalter-Feedback für das Frontend (Firestore-Logik folgt im nächsten Paket)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Auswahl „${_selectedCuisine!.displayName}“ vorgemerkt.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Essensrichtung wählen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // reminder banner
                VotingReminderBanner(
                  hostName: widget.hostName,
                  deadlineText: widget.deadlineText,
                ),
                const SizedBox(height: 20),
                // headline
                Text(
                  'Worauf hast du heute Appetit?',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Wähle deine bevorzugte Essensrichtung:',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),

                // RadioList for choosing cuisine
                CuisineRadioList(
                  selectedCuisine: _selectedCuisine,
                  enabled: widget.isVotingOpen,
                  onChanged: (Cuisine? value) {
                    setState(() {
                      _selectedCuisine = value;
                    });
                  },
                ),
              ],
            ),
          ),

          // fixed Save-Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: widget.isVotingOpen && _selectedCuisine != null
                      ? _onSavePressed
                      : null,
                  child: const Text('Auswahl speichern'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}