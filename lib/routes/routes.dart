import 'package:etkinlikapp/features/event_room/screens/create_event_room_page.dart';
import 'package:etkinlikapp/features/event_room/screens/event_room_details.dart';
import 'package:etkinlikapp/features/auth/screens/login.dart';
import 'package:etkinlikapp/features/bottom_navbar/navbar.dart';
import 'package:etkinlikapp/features/auth/screens/register.dart';
import 'package:etkinlikapp/features/auth/screens/reset_password.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/register': (context) => RegisterPage(),
    '/login': (context) => LoginPage(),
    '/resetpassword': (context) => ResetPasswordPage(),
    '/navbar': (context) => Navbar(),
    '/createeventroom': (context) => CreateEventRoomPage(),
    '/eventroomdetail': (context) => EventRoomDetail(),
    // '/eventroomdetail': (context) {
    //   final args = ModalRoute.of(context)!.settings.arguments;
    //   return EventRoomDetail(eventRoomData: args as EventRoomModel);
    // },
  };
}
