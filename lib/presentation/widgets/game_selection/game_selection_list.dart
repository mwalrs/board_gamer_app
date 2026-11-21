import 'package:flutter/material.dart';
import '../../../domain/entities/game_proposal.dart';

class GameSelectionList extends StatelessWidget {
  final List<GameProposal> games;
  final String? selectedGameId;
  final bool enabled;
  final ValueChanged<String?> onChanged;

  const GameSelectionList({
    super.key,
    required this.games,
    required this.selectedGameId,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final game in games)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _GameOptionCard(
              name: game.name,
              isSelected: game.id == selectedGameId,
              enabled: enabled,
              onTap: () => onChanged(game.id),
            ),
          ),
      ],
    );
  }
}

class _GameOptionCard extends StatelessWidget {
  final String name;
  final bool isSelected;
  final bool enabled;
  final VoidCallback onTap;

  const _GameOptionCard({
    required this.name,
    required this.isSelected,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.1)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected ? colorScheme.primary : colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }
}