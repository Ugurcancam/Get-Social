import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                AuthService().resetPassword(context, email: emailController.text);
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
