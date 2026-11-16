import 'package:board_gamer_app/themes/colors.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              mainAxisAlignment: .center,
              children: [
                const Spacer(flex: 2),
                Icon(
                    Icons.casino,
                    size: 100.0,
                    color: BoardGameColors.accent500),
                const Spacer(flex: 2),
                Text(
                  'Board Gamer',
                  style: textTheme.displayMedium,
                  textAlign: .center,
                ),
                const SizedBox(height: 25),
                Divider(
                  height: 2,
                  thickness: 2,
                  color: BoardGameColors.divider,
                ),
                const SizedBox(height: 25),
                Text(
                  'Wir erinnern dich 15 Minuten vor jedem Spieleabend - auch wenn die App zu ist.',
                  style: textTheme.bodyMedium,
                  textAlign: .center,
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // notification check or navigation to new screen
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Los geht's"),
                    iconAlignment: .end,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}