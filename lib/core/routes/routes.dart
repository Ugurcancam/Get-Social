import 'package:etkinlikapp/features/auth/screens/login/login_view.dart';
import 'package:etkinlikapp/features/auth/screens/register/register_view.dart';
import 'package:etkinlikapp/features/auth/screens/reset_password_view.dart';
import 'package:etkinlikapp/features/auth/screens/sign_in_options_view.dart';
import 'package:etkinlikapp/features/auth/screens/verify_mail/verify_email_view.dart';
import 'package:etkinlikapp/features/bottom_navbar/bottom_navbar.dart';
import 'package:etkinlikapp/features/event_room/screens/create_event_room/create_event_room_select_location_view.dart';
import 'package:etkinlikapp/features/profile/screens/profile/profile_view.dart';
import 'package:etkinlikapp/features/update_users_location/screens/update_users_location_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    // Auth
    '/signinoptions': (context) => const SignInOptionsView(),
    '/register': (context) => RegisterView(),
    '/login': (context) => LoginView(),
    '/verifyemail': (context) => const VerifyEmailPage(),
    '/forgotpassword': (context) => ResetPasswordView(),

    // Home
    '/homepage': (context) => BottomNavbar(),

    // Event Room
    '/createeventroom': (context) => CreateEventRoomSelectLocationView(),
    //'/eventroomdetail': (context) => EventRoomDetail(),

    // Profile
    '/profileview': (context) => ProfileView(),

    '/updatelocation': (context) => UpdateUsersLocationView(),
  };
}
