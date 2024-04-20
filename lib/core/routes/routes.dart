import 'package:etkinlikapp/features/auth/screens/login_view.dart';
import 'package:etkinlikapp/features/auth/screens/register_view.dart';
import 'package:etkinlikapp/features/auth/screens/reset_password_view.dart';
import 'package:etkinlikapp/features/auth/screens/sign_in_options_view.dart';
import 'package:etkinlikapp/features/auth/screens/verify_email_view.dart';
import 'package:etkinlikapp/features/bottom_navbar/bottom_navbar.dart';
import 'package:etkinlikapp/features/event_room/screens/create_event_room_view.dart';
import 'package:etkinlikapp/features/profile/screens/profile_detail_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    // Auth
    '/signinoptions': (context) => const SignInOptionsView(),
    '/register': (context) => RegisterView(),
    '/login': (context) => const LoginView(),
    '/verifyemail': (context) => const VerifyEmailPage(),
    '/forgotpassword': (context) => ResetPasswordView(),

    // Home
    '/homepage': (context) => BottomNavbar(),

    // Event Room
    '/createeventroom': (context) => CreateEventRoomPage(),
    //'/eventroomdetail': (context) => EventRoomDetail(),

    // Profile
    '/profiledetail': (context) => ProfileDetail(),
  };
}
