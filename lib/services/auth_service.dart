import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlikapp/pages/Home/HomePage.dart';
import 'package:etkinlikapp/pages/Login/LoginPage.dart';
import 'package:etkinlikapp/pages/VerifyEmail/verify_email.dart';
import 'package:etkinlikapp/pages/ortasayfa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  Future<void> signUp(BuildContext context, {required String nameSurname, required String email, required String password}) async {
    final navigator = Navigator.of(context);
    try {
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        _registerUser(
          uid: userCredential.user!.uid,
          nameSurname: nameSurname,
          email: email,
        );
        navigator.push(MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } on FirebaseAuthException catch (error) {
      print(error.toString());
    }
  }

  Future<void> _registerUser({required String uid, required String nameSurname, required String email}) async {
    await userCollection.doc().set({
      "uid": uid,
      "email": email,
      "namesurname": nameSurname,
    });
  }

  Future<void> signIn(BuildContext context, {required String email, required String password}) async {
    final navigator = Navigator.of(context);
    try {
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        navigator.push(MaterialPageRoute(builder: (context) => firebaseAuth.currentUser!.emailVerified ? HomePage() : VerifyEmailPage()));
      }
    } on FirebaseAuthException catch (error) {
      print(error.toString());
    }
    // try {
    //   if (userCredential.user != null) {
    //     // Get the FCM token
    //     String? fcmToken = await FirebaseMessaging.instance.getToken();

    //     // Update the user's 'token' field in Firestore with the FCM token
    //     await userCollection.where("email", isEqualTo: email).get().then((querySnapshot) {
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
    navigator.push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future<void> resetPassword(BuildContext context, {required String email}) async {
    final navigator = Navigator.of(context);
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      navigator.push(MaterialPageRoute(builder: (context) => LoginPage()));
    } on FirebaseAuthException catch (error) {
      print(error.toString());
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await firebaseAuth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (error) {
      print(error.toString());
    }
  }
}
