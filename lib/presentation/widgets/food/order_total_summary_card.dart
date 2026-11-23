import 'package:flutter/material.dart';
import '../../../themes/colors.dart';

class OrderTotalSummaryCard extends StatelessWidget {
  final int itemCount;
  final double totalPrice;
  final String hostName;

  const OrderTotalSummaryCard({
    super.key,
    required this.itemCount,
    required this.totalPrice,
    required this.hostName,
  });

  String _formatEuro(double value) {
    return '${value.toStringAsFixed(2).replaceAll('.', ',')} €';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: BoardGameColors.accent100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Zu zahlen an Host ($hostName)',
                    style: textTheme.labelMedium?.copyWith(
                      color: BoardGameColors.accent800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    itemCount == 0
                        ? 'Keine Artikel ausgewählt'
                        : '$itemCount ${itemCount == 1 ? 'Artikel' : 'Artikel'} ausgewählt',
                    style: textTheme.bodyMedium?.copyWith(
                      color: BoardGameColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              _formatEuro(totalPrice),
              style: textTheme.labelMedium?.copyWith(
                fontSize: 18,
                color: BoardGameColors.accent700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}