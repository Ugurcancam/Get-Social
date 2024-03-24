import 'package:etkinlikapp/features/auth/screens/login_deneme.dart';
import 'package:etkinlikapp/features/auth/screens/register_deneme.dart';
import 'package:etkinlikapp/features/auth/screens/register_view.dart';
import 'package:etkinlikapp/features/event_room/screens/pick_file_view.dart';
import 'package:etkinlikapp/features/onboarding/onboarding_screens_view.dart';
import 'package:etkinlikapp/firebase_options.dart';
import 'package:etkinlikapp/features/auth/screens/login_view.dart';
import 'package:etkinlikapp/features/bottom_navbar/navbar.dart';
import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/core/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        //ChangeNotifierProvider(create: (context) => RoomProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            routes: AppRoutes.routes,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: Navbar(),
          );
        } else {
          return MaterialApp(
            routes: AppRoutes.routes,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: LoginDeneme(),
          );
        }
      },
    );
  }
}
