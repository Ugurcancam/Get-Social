import 'package:etkinlikapp/core/constants/constants.dart';
import 'package:etkinlikapp/core/routes/routes.dart';
import 'package:etkinlikapp/core/services/locale_data_service.dart';
import 'package:etkinlikapp/features/auth/domain/models/user_model.dart';
import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/features/auth/screens/sign_in_options_view.dart';
import 'package:etkinlikapp/features/bottom_navbar/bottom_navbar.dart';
import 'package:etkinlikapp/features/event_room/screens/sdfsf.dart';
import 'package:etkinlikapp/features/event_room/screens/yeni.dart';
import 'package:etkinlikapp/firebase_options.dart';
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
          LocalDataService().saveUserEmail(snapshot.data!.email!);
          LocalDataService().saveUserId(snapshot.data!.uid);
          return MaterialApp(
            routes: AppRoutes.routes,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
            ),
            home: BottomNavbar(),
          );
        } else {
          return MaterialApp(
            routes: AppRoutes.routes,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
            ),
            home: SignInOptionsView(),
          );
        }
      },
    );
  }
}
