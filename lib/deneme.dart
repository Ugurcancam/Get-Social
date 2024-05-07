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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_background.jpg"), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo (Optional)
                // FlutterLogo(size: 150.0),
                SizedBox(height: 20.0),
                _buildEmailField(),
                SizedBox(height: 10.0),
                // Email Field
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
                _buildLoginButton(),
                SizedBox(height: 10.0),
                _buildForgotPasswordAndTerms(),
                SizedBox(height: 10.0),

                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.golf_course,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Login with Google",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // _buildOrContinueWithText(),
                // SizedBox(height: 10.0),
                // _buildSocialLoginButtons(),
              ],
            ),
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
        labelText: "Password",
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
      child: Text("Login"),
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        minimumSize: Size(double.infinity, 50.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordAndTerms() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            // Handle forgot password logic
          },
          child: Text(
            "Forgot Password?",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: _agreeToTerms,
              onChanged: (value) => setState(() => _agreeToTerms = value!),
            ),
            Text("Accept Terms & Conditions"),
          ],
        ),
      ],
    );
  }
}
