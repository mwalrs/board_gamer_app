import 'package:board_gamer_app/presentation/screens/login_screen.dart';
import 'package:board_gamer_app/presentation/screens/event_overview.dart';
import 'package:flutter/material.dart';

class AuthWrapper  extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {

  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();

    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    // TODO firebase login
    const authenticated = false;

    // checks if state is still available
    if (!mounted) {
      return;
    }

    setState(() {
      isLoggedIn = authenticated;
    });
  }



  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null || isLoggedIn == false) {
      return const LoginScreen();
    }

    return const EventOverviewScreen();
  }
}