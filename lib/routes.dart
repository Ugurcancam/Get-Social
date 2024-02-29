import 'package:etkinlikapp/pages/Login/LoginPage.dart';
import 'package:etkinlikapp/pages/Register/RegisterPage.dart';
import 'package:etkinlikapp/pages/ResetPassword/reset_password.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/register': (context) => RegisterPage(),
    '/login': (context) => LoginPage(),
    '/resetpassword': (context) => ResetPasswordPage(),
  };
}
