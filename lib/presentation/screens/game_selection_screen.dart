import 'package:flutter/material.dart';
import '../../domain/entities/game_proposal.dart';
import '../widgets/game_selection/event_notice_box.dart';
import '../widgets/game_selection/game_selection_list.dart';

class GameSelectionScreen extends StatefulWidget {
  final List<GameProposal> games;
  final bool isVotingOpen;

  const GameSelectionScreen({
    super.key,
    required this.games,
    this.isVotingOpen = true,
  });

  @override
  State<GameSelectionScreen> createState() => _GameSelectionScreenState();
}

class _GameSelectionScreenState extends State<GameSelectionScreen> {
  String? _selectedGameId;
  bool _hasVoted = false;

  void _onSavePressed() {
    if (_selectedGameId == null) return;

    final selectedGame =
    widget.games.firstWhere((game) => game.id == _selectedGameId);

    setState(() => _hasVoted = true);

    // Platzhalter Feedback (Firestore Logik kommt spaeter)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Stimme für „${selectedGame.name}“ abgegeben.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final canVote = widget.isVotingOpen && !_hasVoted;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spielauswahl'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const EventNoticeBox(),
                const SizedBox(height: 20),
                Text(
                  'Welches Spiel soll gespielt werden?',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text('Stimme ab', style: textTheme.bodyMedium),
                const SizedBox(height: 8),
                Text(
                  'Die Abstimmung wird 12 Stunden vor dem Spieltermin '
                      'geschlossen.',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),

                // Spieleliste fuer Abstimmung
                GameSelectionList(
                  games: widget.games,
                  selectedGameId: _selectedGameId,
                  enabled: canVote,
                  onChanged: (String? value) {
                    setState(() => _selectedGameId = value);
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  'Nach dem Speichern ist die Stimmabgabe endgültig '
                      'und kann nicht rückgängig gemacht werden.',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),

          // fixed Speicherbutton, scrollt nicht mit.
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed:
                  canVote && _selectedGameId != null ? _onSavePressed : null,
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