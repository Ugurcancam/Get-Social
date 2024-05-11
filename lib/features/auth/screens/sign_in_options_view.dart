import 'package:etkinlikapp/features/auth/widget/login_options_widget.dart';
import 'package:flutter/material.dart';

class SignInOptionsView extends StatelessWidget {
  const SignInOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/signinoptions_background.jpg',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Text on the photo',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/register'),
                child: Container(
                  width: 320,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromRGBO(95, 25, 242, 1),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 8),
                      Text(
                        'Kayıt ol',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // const LoginOptionButton(
              //   imagePath: 'google_icon',
              //   loginOptionText: 'Google ile devam et',
              //   path: '',
              // ),
              // const SizedBox(height: 20),
              // const LoginOptionButton(
              //   imagePath: 'apple_icon',
              //   loginOptionText: 'Apple ile devam et',
              //   path: '',
              // ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/login'),
                child: const Text(
                  'Giriş Yap',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
