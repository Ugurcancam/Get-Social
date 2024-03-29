import 'package:etkinlikapp/features/auth/domain/view_models/login_view_model.dart';
import 'package:etkinlikapp/features/auth/screens/login_view.dart';
import 'package:flutter/material.dart';

mixin LoginViewMixin on State<LoginView> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final LoginViewModel loginViewModel = LoginViewModel();

  // Şifre görünürlüğü kontrolü için
  bool isPasswordVisible = false;

  // Textfield'lar için controller'lar
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Controller'dan gelen verileri almak için
  String get valueByEmailController => emailController.value.text;
  String get valueByPasswordController => passwordController.value.text;

  // Sayfa boyutlarını almak için
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  // Şifre görünürlüğünü kontrol etmek için
  void controlPasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
