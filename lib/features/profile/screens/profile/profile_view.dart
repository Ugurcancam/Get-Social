import 'package:codegen/codegen.dart';
import 'package:etkinlikapp/features/auth/domain/models/user_model.dart';
import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:etkinlikapp/features/profile/domain/services/user_service.dart';
import 'package:etkinlikapp/features/profile/screens/select_profile_picture/select_profile_picture_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'profile_view_mixin.dart';
part 'profile_subview.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with ProfileViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _userService.getUserDetails(email!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final user = snapshot.data;
            return ListView(
              children: [
                _UsersInformationWidget(user: user, navigateToSelectProfilePicture: navigateToSelectProfilePicture),
                const SizedBox(
                  height: 20,
                ),
                LanguageListTile(iconForward: iconForward),
                const SizedBox(
                  height: 12,
                ),
                _InviteFriendsListTile(iconForward: iconForward),
                const SizedBox(
                  height: 12,
                ),
                _HelpCenterListTile(iconForward: iconForward),
                const SizedBox(
                  height: 12,
                ),
                _FeedbackListTile(iconForward: iconForward),
                const SizedBox(
                  height: 12,
                ),
                _PrivacyPolicyListTile(iconForward: iconForward),
                const SizedBox(
                  height: 12,
                ),
                _LogOutListTile(
                  iconForward: iconForward,
                  logOut: _logOut,
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
