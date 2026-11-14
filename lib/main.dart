import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:board_gamer_app/themes/app_theme.dart';
import 'package:board_gamer_app/themes/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint('Firebase successfully initialized!');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Board Gamer App',
      theme: AppTheme.theme(),
      themeMode: ThemeMode.light,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final TextTheme currentTextTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const SizedBox(height: 200),
              Icon(
                  Icons.casino,
                  size: 100.0,
                  color: BoardGameColors.accent500),
              const SizedBox(height: 150),
              Text(
                'Board Gamer',
                style: currentTextTheme.displayMedium,
                textAlign: TextAlign.center,
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
                style: currentTextTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {

                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("Los geht's"),
                  iconAlignment: IconAlignment.end,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
