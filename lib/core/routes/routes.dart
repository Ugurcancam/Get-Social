import 'package:etkinlikapp/features/event_room/screens/create_event_room_view.dart';
import 'package:etkinlikapp/features/event_room/screens/event_room_details_view.dart';
import 'package:etkinlikapp/features/auth/screens/login_view.dart';
import 'package:etkinlikapp/features/bottom_navbar/navbar.dart';
import 'package:etkinlikapp/features/auth/screens/register_view.dart';
import 'package:etkinlikapp/features/auth/screens/reset_password_view.dart';
import 'package:etkinlikapp/features/profile/screens/profile_detail_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/register': (context) => RegisterPage(),
    '/login': (context) => LoginPage(),
    '/resetpassword': (context) => ResetPasswordPage(),
    '/navbar': (context) => Navbar(),
    '/createeventroom': (context) => CreateEventRoomPage(),
    '/eventroomdetail': (context) => EventRoomDetail(),
    '/profiledetail': (context) => ProfileDetail(),
    // '/eventroomdetail': (context) {
    //   final args = ModalRoute.of(context)!.settings.arguments;
    //   return EventRoomDetail(eventRoomData: args as EventRoomModel);
    // },
  };
}
