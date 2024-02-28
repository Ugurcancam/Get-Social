import 'package:etkinlikapp/pages/Login/LoginPage.dart';
import 'package:etkinlikapp/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key});

  final TextEditingController nameSurnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Üye Ol'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameSurnameController,
              decoration: InputDecoration(
                labelText: 'Ad Soyad',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Eposta',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: sifreController,
              decoration: InputDecoration(
                labelText: 'Şifre',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                AuthService().signUp(
                  context,
                  nameSurname: nameSurnameController.text,
                  email: emailController.text,
                  password: sifreController.text,
                );
              },
              child: const Text('Üye Ol'),
            ),
            const Spacer(),
            const Text('Hesabın var mı?'),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
