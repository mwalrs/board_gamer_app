import 'package:flutter/material.dart';

class FoodProcessStatusCard extends StatelessWidget {
  /// Matches the `foodStatus` field in Firestore: ‘pending’, ‘in_progress’, 'completed'
  final String foodStatus;
  final String hostName;
  final String? selectedRestaurantName;
  final bool isVotingOpen;

  const FoodProcessStatusCard({
    super.key,
    required this.foodStatus,
    required this.hostName,
    this.selectedRestaurantName,
    this.isVotingOpen = true,
  });

  @override
  Widget build(BuildContext context) {
    final statusInfo = _resolveStatusInfo();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(statusInfo.icon),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    statusInfo.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              statusInfo.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Divider(height: 24),
            _buildStepRow(
              context,
              stepNumber: '1',
              label: 'Wahl der Essensrichtung',
              isDone: foodStatus != 'pending' || !isVotingOpen,
              isActive: foodStatus == 'pending' && isVotingOpen,
            ),
            const SizedBox(height: 8),
            _buildStepRow(
              context,
              stepNumber: '2',
              label: selectedRestaurantName != null && selectedRestaurantName!.isNotEmpty
                  ? 'Restaurant: $selectedRestaurantName'
                  : 'Restaurantwahl durch Host ($hostName)',
              isDone: foodStatus == 'in_progress' || foodStatus == 'completed',
              isActive: foodStatus == 'pending' && !isVotingOpen,
            ),
            const SizedBox(height: 8),
            _buildStepRow(
              context,
              stepNumber: '3',
              label: 'Essensbestellung & Abschluss',
              isDone: foodStatus == 'completed',
              isActive: foodStatus == 'in_progress',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepRow(
      BuildContext context, {
        required String stepNumber,
        required String label,
        required bool isDone,
        required bool isActive,
      }) {
    IconData iconData = Icons.radio_button_unchecked;
    if (isDone) {
      iconData = Icons.check_circle;
    } else if (isActive) {
      iconData = Icons.pending;
    }

    return Row(
      children: [
        Icon(iconData, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$stepNumber. $label',
            style: isActive
                ? Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)
                : Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  _StatusDisplayData _resolveStatusInfo() {
    switch (foodStatus) {
      case 'in_progress':
        return _StatusDisplayData(
          icon: Icons.restaurant_menu,
          title: 'Bestellphase läuft',
          description:
          '${selectedRestaurantName ?? 'Ein Restaurant'} wurde festgelegt. Du kannst jetzt deine Artikel eintragen.',
        );
      case 'completed':
        return const _StatusDisplayData(
          icon: Icons.task_alt,
          title: 'Bestellung abgeschlossen',
          description:
          'Gastgeber hat die Sammelbestellung ausgelöst. Änderungen sind nicht mehr möglich.',
        );
      case 'pending':
      default:
        if (isVotingOpen) {
          return _StatusDisplayData(
            icon: Icons.how_to_vote,
            title: 'Abstimmung über Essensrichtung',
            description:
            'Stimme bis 2 Stunden vor Beginn ab, damit $hostName ein passendes Restaurant wählen kann.',
          );
        } else {
          return _StatusDisplayData(
            icon: Icons.hourglass_bottom,
            title: 'Warten auf Restaurantwahl',
            description:
            'Die Abstimmung ist beendet. $hostName wählt aktuell das Restaurant aus.',
          );
        }
    }
  }
}

class _StatusDisplayData {
  final IconData icon;
  final String title;
  final String description;

  const _StatusDisplayData({
    required this.icon,
    required this.title,
    required this.description,
  });
}