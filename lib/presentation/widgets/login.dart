import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty)  {
      return "Username darf nicht leer sein!";
    }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return "Verwendung ungueltiger Zeichen!";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password darf nicht leer sein!';
    }
    if (value.length < 8) {
      return 'Password muss mindestens 8 Zeichen besitzen!';
    }
    return null;
  }

  Future<void> _handleFirebaseLogin(String username, String password) async {
    // TODO handle login
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: "Username",
              labelText: "Username",
              prefixIcon: Icon(Icons.person),
            ),
            controller: _usernameController,
            validator: validateUsername,
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Password",
              labelText: "Password",
              prefixIcon: Icon(Icons.key),
            ),
            controller: _passwordController,
            validator: validatePassword,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final username = _usernameController.text;
                  final password = _passwordController.text;

                  // TODO Firebase Login and error management

                  _usernameController.clear();
                  _passwordController.clear();
                }
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Anmelden"),
              iconAlignment: .end,
            ),
          ),
        ],
      ),
    );
  }
}