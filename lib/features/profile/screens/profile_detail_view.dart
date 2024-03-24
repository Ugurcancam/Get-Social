import 'dart:io';

import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/features/profile/domain/services/user_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDetail extends StatefulWidget {
  ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  PlatformFile? file;

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = Provider.of<UserProvider>(context).email;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Detail'),
      ),
      body: FutureBuilder(
        future: UserService().getUserDetails(email!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            return ListView(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_image.png'),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                if (file != null) Text(file!.name),
                ListTile(
                  leading: Icon(Icons.person), // Add icon to the leading property
                  title: Text('Ad Soyad'),
                  subtitle: Text(user!.namesurname),
                ),
                SizedBox(
                  height: 25,
                ),
                ListTile(
                  leading: Icon(Icons.email), // Add icon to the leading property
                  title: Text('Email'),
                  subtitle: Text(email),
                ),
                ElevatedButton(onPressed: () => selectFile(), child: Text('Dosya Seç')),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(child: Text('No data'));
        },
      ),
    );
  }
}
