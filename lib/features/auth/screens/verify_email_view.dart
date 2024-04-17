import 'dart:async';

import 'package:etkinlikapp/features/bottom_navbar/bottom_navbar.dart';
import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _startTimer() {
    const refreshInterval = Duration(seconds: 1);
    _timer = Timer.periodic(refreshInterval, (Timer timer) {
      checkEmailVerificationStatus();
      print("object");
    });
  }

  void checkEmailVerificationStatus() async {
    await FirebaseAuth.instance.currentUser!.reload();
    bool verified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (verified) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNavbar()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AuthService().sendEmailVerification();
          },
          child: Text('Send Verification Link'),
        ),
      ),
    );
  }
}
