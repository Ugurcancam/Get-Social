import 'dart:async';

import 'package:etkinlikapp/core/constants/constants.dart';
import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:etkinlikapp/features/auth/domain/view_models/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

part 'login_sub_view.dart';
part 'login_view_mixin.dart';

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
        child: Padding(
          padding: const EdgeInsets.only(right: 32, left: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.20),
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
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: isTermsAccepted,
                    onChanged: (value) {
                      setState(() {
                        isTermsAccepted = !isTermsAccepted;
                        print(isTermsAccepted);
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Beni hatırla',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Kullanım Koşulları',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              LoginButtonField(
                isTermsAccepted: isTermsAccepted,
                formKey: loginFormKey,
                valueByEmailController: valueByEmailController,
                valueByPasswordController: valueByPasswordController,
              ),
              const SizedBox(height: 20),
              const NavigateToRegisterPage(),
              SizedBox(height: height * 0.16),
              const ForgotPasswordText(),
            ],
          ),
        ),
      ),
    );
  }
}
