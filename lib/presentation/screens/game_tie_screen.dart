import 'package:flutter/material.dart';
import '../../domain/entities/game_proposal.dart';
import '../widgets/game_selection/game_selection_list.dart';
import '../widgets/game_selection/game_tie_notice_box.dart';

class GameTieScreen extends StatefulWidget {
  final List<GameProposal> tiedGames;
  final String hostName;

  const GameTieScreen({
    super.key,
    required this.tiedGames,
    required this.hostName,
  });

  // Zur Zustandsklasse
  @override
  State<GameTieScreen> createState() => _GameTieScreenState();
}

// Zustandsklasse
class _GameTieScreenState extends State<GameTieScreen> {
  String? _selectedGameId;
  bool _isDecided = false;

  void _onConfirmPressed() {
    if (_selectedGameId == null) return; // Abbruch, wenn nichts gewählt

    final selectedGame =
    widget.tiedGames.firstWhere((game) => game.id == _selectedGameId);

    setState(() => _isDecided = true); // Status ändern

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Spiel „${selectedGame.name}“ festgelegt.')),
    );

    Navigator.of(context).maybePop(); // Screen zurück
  }

  // Screen
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gleichstand'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                GameTieNoticeBox(tiedGames: widget.tiedGames),
                const SizedBox(height: 20),
                Text(
                  'Welches Spiel soll gespielt werden?',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Gastgeber:in ${widget.hostName} entscheidet zwischen den '
                      'Spielen mit den meisten Stimmen.',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                GameSelectionList(
                  games: widget.tiedGames,
                  selectedGameId: _selectedGameId,
                  enabled: !_isDecided,
                  onChanged: (String? value) {
                    setState(() => _selectedGameId = value);
                  },
                ),
              ],
            ),
          ),

          // fixed Bestätigungsbutton
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  // noch nicht entschieden && Spiel ist gewählt
                  onPressed: !_isDecided && _selectedGameId != null
                      ? _onConfirmPressed
                      : null,
                  child: const Text('Spie festlegen'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}