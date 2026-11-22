import 'package:flutter/material.dart';
import '../../../domain/entities/game_proposal.dart';

class GameTieNoticeBox extends StatelessWidget {
  final List<GameProposal> tiedGames;

  const GameTieNoticeBox({super.key, required this.tiedGames});

  //Spielkarten aus gleichen Namen bauen
  String get _gameNames {
    final names = tiedGames.map((game) => game.name).toList();
    if (names.length <= 1) return names.join();   //bei einem oder KEINEM Namen diesen zurueckgeben
    return '${names.sublist(0, names.length -1).join('.')}'    // -1 funktioniert bei jeder Anzahl
      'und ${names.last}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    //Die Box
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: textTheme.bodyMedium,
                children: [
                  const TextSpan(
                    text: 'Abstimmung beendet: ',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: '$_gameNames haben gleich viele Stimmen.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
