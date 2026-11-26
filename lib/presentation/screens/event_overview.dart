import 'package:flutter/material.dart';

class EventOverviewScreen extends StatelessWidget {
  const EventOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spieleabende',
          style: textTheme.titleLarge,
          textAlign: .left,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(padding: const EdgeInsets.all(20), child: Column()),
        ),
      ),
    );
  }
}
