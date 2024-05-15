import 'dart:async';

import 'package:codegen/codegen.dart';
import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:etkinlikapp/features/auth/domain/view_models/login_view_model.dart';
import 'package:etkinlikapp/features/auth/widget/login_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

part 'login_view_mixin.dart';
part 'login_sub_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: Form(
        autovalidateMode: AutovalidateMode.disabled,
        key: loginFormKey,
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Giriş Yap,',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Merhaba! Tekrar hoşgeldiniz.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                EmailTextFormField(
                  emaillController: emailController,
                  loginViewModel: loginViewModel,
                ),
                const SizedBox(height: 15),
                PasswordTextFormField(
                  passworddController: passwordController,
                  loginViewModel: loginViewModel,
                  isPasswordVisible: isPasswordVisible,
                  controlPasswordVisibility: controlPasswordVisibility,
                ),
                const SizedBox(height: 15),
                RememberMeAndForgotPassword(
                  isRememberMeChecked: isRememberMeChecked,
                  onRememberMeChanged: (value) {
                    setState(() {
                      isRememberMeChecked = value;
                    });
                  },
                  onForgotPasswordPressed: () => showForgotPasswordBottomSheet(context),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () async {
                    if (loginFormKey.currentState!.validate()) {
                      // Show loading widget for 2 seconds
                      final loadingCompleter = Completer<void>();
                      Timer(const Duration(seconds: 2), loadingCompleter.complete);
                      showLoadingAnimation(context);

                      // Execute sign-in logic after delay
                      await loadingCompleter.future;
                      await AuthService().signIn(context, email: valueByEmailController, password: valueByPasswordController);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorName.primary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Giriş Yap', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 100),
                const DividerWithText(),
                const SizedBox(height: 30),
                const OtherLoginOptions(),
                const SizedBox(height: 30),
                const NavigateToRegister(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
