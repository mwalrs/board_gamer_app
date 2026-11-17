import 'package:flutter/material.dart';
import '../../../domain/entities/cuisine.dart';

class CuisineRadioList extends StatelessWidget {
  final List<Cuisine> cuisines;
  final Cuisine? selectedCuisine;
  final ValueChanged<Cuisine?> onChanged;
  final bool enabled;

  const CuisineRadioList({
    super.key,
    this.cuisines = Cuisine.values,
    required this.selectedCuisine,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return RadioGroup<Cuisine>(
      groupValue: selectedCuisine,
      onChanged: enabled ? onChanged : (_) {},
      child: Column(
        children: cuisines.map((cuisine) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: RadioListTile<Cuisine>(
                value: cuisine,
                enabled: enabled,
                secondary: Text(
                  cuisine.icon,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(cuisine.displayName),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}