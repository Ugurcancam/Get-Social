import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codegen/codegen.dart';
import 'package:etkinlikapp/features/profile/domain/services/user_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

part 'profile_detail_mixin.dart';

class ProfileDetail extends StatefulWidget {
  ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> with ProfileDetailMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilim'),
      ),
      body: FutureBuilder(
        future: UserService().getUserDetails(email!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            return ListView(
              children: [
                if (user!.profilePhotoURL != '')
                  InkWell(
                    child: Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user.profilePhotoURL!),
                      ),
                    ),
                  )
                else
                  InkWell(
                    onTap: _pickFile,
                    child: Center(
                      child: _filePath != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: Image.file(
                                File(_filePath!),
                                width: 150,
                                height: 150,
                              ).image,
                            )
                          : Image.asset(
                              Assets.images.imgNoProfilePic.path,
                              width: 150,
                              height: 150,
                            ),
                    ),
                  ),

                const SizedBox(
                  height: 25,
                ),
                ListTile(
                  leading: const Icon(Icons.person), // Add icon to the leading property
                  title: const Text('Ad Soyad'),
                  subtitle: Text(user!.namesurname),
                ),
                const SizedBox(
                  height: 25,
                ),
                ListTile(
                  leading: const Icon(Icons.email), // Add icon to the leading property
                  title: const Text('Email'),
                  subtitle: Text(email!),
                ),

                const SizedBox(height: 16),
                //Show the selected image on phone

                Container(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _uploadFile,
                  child: const Text('Kaydet'),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}
