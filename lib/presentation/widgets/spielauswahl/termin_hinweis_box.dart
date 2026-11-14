import 'package:flutter/material.dart';

class TerminHinweisBox extends StatelessWidget {
  const TerminHinweisBox({super.key});

  Widget _zeile(String titel, String wert) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
            fontSize: 15, height: 1.5, color: Color(0xFF2B3045)),
        children: [
          TextSpan(
              text: '$titel: ',
              style: const TextStyle(fontWeight: FontWeight.w700)),
          TextSpan(text: wert),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E3),
        border: Border.all(color: const Color(0xFFF4DC92), width: 1.5),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.calendar_month_outlined,
                color: Color(0xFFC97D00), size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _zeile('Spieltermin', 'Fr., 23.10.2026, 18:30–23:00'),
                _zeile('Ort', 'Bergstraße 12'),
                _zeile('Gastgeber:in', 'Alex'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}