import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlikapp/features/auth/domain/models/user_model.dart';
import 'package:etkinlikapp/features/bottom_navbar/bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection('users');
  final firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  Future<void> signUp(BuildContext context, {required String nameSurname, required String email, required String password, required String dateOfBirth, required String province, required String district}) async {
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
          district: district,
        );
        await userCredential.user!.sendEmailVerification();
        await navigator.pushNamed('/login');
      }
    } on FirebaseAuthException catch (error) {
      print(error.toString());
    }
  }

  Future<void> _registerUser({required String userId, required String nameSurname, required String email, required String dateOfBirth, required String province, required String district}) async {
    await userCollection.doc(userId).set({
      'uid': userId,
      'email': email,
      'namesurname': nameSurname,
      'dateOfBirth': dateOfBirth,
      'province': province,
      'district': district,
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

  Future<void> logOut(BuildContext context) async {
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

  Future<void> checkEmailVerificationStatus(BuildContext context) async {
    await FirebaseAuth.instance.currentUser!.reload();
    final verified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (verified) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavbar()), (route) => false);
    }
  }

  // Fetch user details from Firestore which email is equal to the email of the current user
  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await db.collection('users').where('email', isEqualTo: email).get();
    final userData = snapshot.docs.map(UserModel.fromSnapshot).single;
    return userData;
  }
}
