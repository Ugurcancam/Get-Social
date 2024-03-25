import 'package:etkinlikapp/features/auth/widget/login_option_buttons.dart';
import 'package:flutter/material.dart';

class LoginDeneme extends StatefulWidget {
  @override
  _LoginDenemeState createState() => _LoginDenemeState();
}

class _LoginDenemeState extends State<LoginDeneme> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/login_background.jpg',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Merhaba,',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Tekrar hoşgeldiniz.',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: width * 0.82,
                height: height * 0.08,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color.fromRGBO(49, 62, 85, 0.78)),
                child: Center(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'E-posta',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: width * 0.82,
                height: height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color.fromRGBO(49, 62, 85, 0.78),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Şifre',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 16),
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Expanded(
                        child: Icon(Icons.visibility_off, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: const Text(
                  'Şifremi Unuttum',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                        'Giriş Yap',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/register'),
                child: const Text.rich(TextSpan(
                  text: 'Bir hesabınız yok mu? ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Kayıt ol',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
