import 'package:flutter/material.dart';
import '../../../themes/colors.dart';

class OrderItemFormCard extends StatelessWidget {
  final int index;
  final TextEditingController dishController;
  final TextEditingController priceController;
  final TextEditingController noteController;
  final bool enabled;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  const OrderItemFormCard({
    super.key,
    required this.index,
    required this.dishController,
    required this.priceController,
    required this.noteController,
    required this.onRemove,
    required this.onChanged,
    this.enabled = true,
  });

  String? _validateDish(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bitte Gericht oder Artikelnummer eingeben.';
    }
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bitte Preis eingeben.';
    }
    final normalized = value.trim().replaceAll(',', '.');
    final parsed = double.tryParse(normalized);
    if (parsed == null || parsed < 0) {
      return 'Bitte gültigen Preis eingeben (z. B. 11,50).';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Artikel ${index + 1}',
                  style: textTheme.labelMedium,
                ),
                if (enabled)
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: BoardGameColors.accent600,
                    ),
                    tooltip: 'Artikel entfernen',
                    onPressed: onRemove,
                  ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: dishController,
              enabled: enabled,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Gericht & Nummer',
                hintText: 'z. B. Nr. 42 Pizza Diavolo',
                border: OutlineInputBorder(),
              ),
              validator: _validateDish,
              onChanged: (_) => onChanged(),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: priceController,
              enabled: enabled,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Einzelpreis (€)',
                hintText: 'z. B. 11,50',
                border: OutlineInputBorder(),
              ),
              validator: _validatePrice,
              onChanged: (_) => onChanged(),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: noteController,
              enabled: enabled,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Sonderwünsche / Anmerkung (optional)',
                hintText: 'z. B. Ohne Zwiebeln, extra Knoblauch',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => onChanged(),
            ),
          ],
        ),
      ),
    );
  }
}