import 'package:board_gamer_app/presentation/widgets/login.dart';
import 'package:board_gamer_app/themes/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Icon(
                  Icons.casino,
                  size: 100.0,
                  color: BoardGameColors.accent500,
                ),
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
                LoginWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
