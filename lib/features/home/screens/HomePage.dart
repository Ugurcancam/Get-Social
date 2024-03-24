import 'package:etkinlikapp/features/auth/domain/models/user_model.dart';
import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:etkinlikapp/features/auth/domain/view_models/user_view_model.dart';
import 'package:etkinlikapp/features/profile/domain/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserViewModel _userViewModel = UserViewModel();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _userViewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/createeventroom');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _authService.signOut(context);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: UserService().getUserDetails(_userViewModel.email!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.hasData) {
              final userdata = snapshot.data!;
              Provider.of<UserProvider>(context, listen: false).setUid(userdata.uid);
              Provider.of<UserProvider>(context, listen: false).setNameSurname(userdata.namesurname);
              Provider.of<UserProvider>(context, listen: false).setEmail(userdata.email);
              return Center(child: Text(userdata.uid));
            }
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}
