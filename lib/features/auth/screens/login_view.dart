import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:etkinlikapp/features/auth/domain/view_models/login_view_model.dart';
import 'package:etkinlikapp/features/auth/screens/login_view_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'login_sub_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> with LoginViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.disabled,
        key: loginFormKey,
        child: Stack(
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
                BuildEmailTextField(
                  width: width,
                  height: height,
                  loginViewModel: loginViewModel,
                  emailController: emailController,
                ),
                const SizedBox(height: 20),
                BuildPasswordTextField(
                  width: width,
                  height: height,
                  isPasswordVisible: isPasswordVisible,
                  passwordController: passwordController,
                  loginViewModel: loginViewModel,
                  onPressed: controlPasswordVisibility,
                ),
                const ForgotPasswordText(),
                const SizedBox(height: 20),
                LoginButtonField(
                  formKey: loginFormKey,
                  valueByEmailController: valueByEmailController,
                  valueByPasswordController: valueByPasswordController,
                ),
                const SizedBox(height: 10),
                const NavigateToRegisterPage(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
