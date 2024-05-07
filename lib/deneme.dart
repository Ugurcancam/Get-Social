import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Merhaba,',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Tekrar hoşgeldiniz.',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              // App Logo (Optional)
              // FlutterLogo(size: 150.0),
              SizedBox(height: 20.0),
              _buildEmailField(),
              SizedBox(height: 15.0),

              // TextField(
              //   keyboardType: TextInputType.emailAddress,
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: Colors.white.withOpacity(0.5),
              //     hintText: "Email",
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       borderSide: BorderSide(
              //         color: Colors.transparent,
              //       ),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       borderSide: BorderSide(
              //         color: Colors.white,
              //       ),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       borderSide: BorderSide(
              //         color: Colors.blue,
              //       ),
              //     ),
              //   ),
              // ),

              _buildPasswordField(),
              SizedBox(height: 15.0),
              _buildForgotPasswordAndTerms(),
              SizedBox(height: 50.0),
              _buildLoginButton(),
              SizedBox(height: 10.0),

              const SizedBox(height: 100),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'veya',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Butona tıklama işlemi (şu anda boş)
                    },
                    child: Container(
                      width: 30, // Container genişliği
                      height: 60, // Container yüksekliği
                      child: Center(
                        child: Image.asset("assets/images/google_icon.png", height: 30),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero, // Buton içeriğinin etrafındaki boşluğu kaldırır
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Butona tıklama işlemi (şu anda boş)
                    },
                    child: Container(
                      width: 30, // Container genişliği
                      height: 60, // Container yüksekliği
                      child: Center(
                        child: Image.asset("assets/images/apple_icon.png", height: 30),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero, // Buton içeriğinin etrafındaki boşluğu kaldırır
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hesabın yok mu?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Butona tıklama işlemi (şu anda boş)
                    },
                    child: Text(
                      "Kayıt Ol",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: Icon(Icons.email),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Şifre",
        prefixIcon: Icon(Icons.lock),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      obscureText: true,
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        // Handle login logic here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        minimumSize: Size(double.infinity, 50.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text('Giriş Yap', style: TextStyle(fontSize: 18.0, color: Colors.white)),
    );
  }

  Widget _buildForgotPasswordAndTerms() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Switch(
              value: _agreeToTerms,
              onChanged: (value) {
                setState(() {
                  _agreeToTerms = value;
                });
              },
            ),
            Text("Beni Hatırla"),
          ],
        ),
        TextButton(
          onPressed: () {
            // Handle forgot password logic
          },
          child: Text(
            "Şifremi Unuttum?",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
