part of 'profile_view.dart';

mixin ProfileViewMixin on State<ProfileView> {
  // File path of the selected image
  String? _filePath;

  //Logged users email
  final email = FirebaseAuth.instance.currentUser!.email;

  final iconForward = const Icon(
    Icons.arrow_forward_ios,
    size: 17,
    color: ColorName.primary,
  );

  //Services
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  // rotue to select profile picture
  void navigateToSelectProfilePicture() {
    Navigator.push(
      context,
      MaterialPageRoute<SelectProfilePictureView>(
        builder: (context) => SelectProfilePictureView(),
      ),
    );
  }

  void _logOut() {
    _authService.logOut(context);
  }
}
