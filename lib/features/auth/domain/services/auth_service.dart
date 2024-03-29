import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection('users');
  final firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  Future<void> signUp(BuildContext context, {required String nameSurname, required String email, required String password, required String dateOfBirth, required String province}) async {
    final navigator = Navigator.of(context);
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await _registerUser(
          userId: userCredential.user!.uid,
          nameSurname: nameSurname,
          email: email,
          dateOfBirth: dateOfBirth,
          province: province,
        );
        await navigator.pushNamed('/login');
      }
    } on FirebaseAuthException catch (error) {
      print(error.toString());
    }
  }

  Future<void> _registerUser({required String userId, required String nameSurname, required String email, required String dateOfBirth, required String province}) async {
    await userCollection.doc(userId).set({
      'uid': userId,
      'email': email,
      'namesurname': nameSurname,
      'dateOfBirth': dateOfBirth,
      'province': province,
    });
  }

  Future<void> signIn(BuildContext context, {required String email, required String password}) async {
    final navigator = Navigator.of(context);
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await navigator.pushNamed(firebaseAuth.currentUser!.emailVerified ? '/homepage' : '/verifyemail');
      }
    } on FirebaseAuthException catch (error) {
      print(error);
    }
    // try {
    //   if (userCredential.user != null) {
    //     // Get the FCM token
    //     String? fcmToken = await FirebaseMessaging.instance.getToken();

    //     // Update the user's 'token' field in Firestore with the FCM token
    //     await userCollection.where('email', isEqualTo: email).get().then((querySnapshot) {
    //       querySnapshot.docs.forEach((doc) {
    //         doc.reference.update({
    //           'token': fcmToken,
    //         });
    //       });
    //     });

    //     navigator.push(MaterialPageRoute(builder: (context) => Anasayfa()));
    //   }
    // } on FirebaseAuthException catch (error) {
    //   Fluttertoast.showToast(msg: error.toString(), toastLength: Toast.LENGTH_LONG);
    // }
  }

  Future<void> signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    await firebaseAuth.signOut();
    await navigator.pushNamedAndRemoveUntil('/login', (route) => false);
    // navigator.pushAndR(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future<void> resetPassword(BuildContext context, {required String email}) async {
    final navigator = Navigator.of(context);
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      await navigator.pushNamed('/login');
    } on FirebaseAuthException catch (error) {
      print(error);
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await firebaseAuth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (error) {
      print(error);
    }
  }
}
