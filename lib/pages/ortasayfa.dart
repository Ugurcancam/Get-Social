import 'package:etkinlikapp/pages/Home/HomePage.dart';
import 'package:etkinlikapp/pages/VerifyEmail/verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Ortasayfa extends StatelessWidget {
  const Ortasayfa({super.key});

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      return VerifyEmailPage();
    }
    return HomePage();
  }
}
