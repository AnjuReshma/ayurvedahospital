import 'package:ayurvedahospital/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<Logincontroller>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
                        SizedBox(height: 24),
            loginState.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      bool success = await loginState.login(
                        usernameController.text,
                        passwordController.text,
                      );

                      scaffoldMessenger.showSnackBar(SnackBar(
                        content: Text(
                          success ? 'Login successful' : 'Login failed',
                        ),
                      ));
                    },
                    child: Text("Login"),
                  ),
          ],
        ),
      ),
    );
  }
}
