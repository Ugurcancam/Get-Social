part of 'profile_view.dart';

class _LogOutListTile extends StatelessWidget {
  const _LogOutListTile({
    required this.iconForward,
    required this.logOut,
    super.key,
  });

  final Icon iconForward;
  final VoidCallback logOut;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.logout,
        color: ColorName.primary,
        size: 25,
      ),
      title: const Text(
        'Çıkış Yap',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: iconForward,
      onTap: logOut,
    );
  }
}

class _PrivacyPolicyListTile extends StatelessWidget {
  const _PrivacyPolicyListTile({
    required this.iconForward,
    super.key,
  });

  final Icon iconForward;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.privacy_tip_outlined,
        color: ColorName.primary,
        size: 25,
      ),
      title: const Text(
        'Gizlilik Politikası',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: iconForward,
    );
  }
}

class _FeedbackListTile extends StatelessWidget {
  const _FeedbackListTile({
    required this.iconForward,
    super.key,
  });

  final Icon iconForward;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.feedback_outlined,
        color: ColorName.primary,
        size: 25,
      ),
      title: const Text(
        'Geri Bildirim',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: iconForward,
    );
  }
}

class _HelpCenterListTile extends StatelessWidget {
  const _HelpCenterListTile({
    required this.iconForward,
    super.key,
  });

  final Icon iconForward;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.help_outline_outlined,
        color: ColorName.primary,
        size: 25,
      ),
      title: const Text(
        'Yardım Merkezi',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: iconForward,
    );
  }
}

class _InviteFriendsListTile extends StatelessWidget {
  const _InviteFriendsListTile({
    required this.iconForward,
    super.key,
  });

  final Icon iconForward;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.person_add_alt_1_outlined,
        color: ColorName.primary,
        size: 25,
      ),
      title: const Text(
        'Arkadaşlarını Davet Et',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: iconForward,
    );
  }
}

class LanguageListTile extends StatelessWidget {
  const LanguageListTile({
    required this.iconForward,
    super.key,
  });

  final Icon iconForward;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.language_outlined,
        color: ColorName.primary,
        size: 25,
      ),
      title: const Text(
        'Dil',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: iconForward,
    );
  }
}

class _UsersInformationWidget extends StatelessWidget {
  const _UsersInformationWidget({
    required this.user,
    required this.navigateToSelectProfilePicture,
    super.key,
  });

  final UserModel? user;
  final VoidCallback navigateToSelectProfilePicture;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (user!.profilePhotoURL != '')
          InkWell(
            onTap: navigateToSelectProfilePicture,
            child: Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user!.profilePhotoURL!),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: ColorName.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          InkWell(
            onTap: navigateToSelectProfilePicture,
            child: Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      Assets.images.imgNoProfilePic.path,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: ColorName.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(
          height: 12,
        ),
        Text(
          user!.namesurname,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          user!.email,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
