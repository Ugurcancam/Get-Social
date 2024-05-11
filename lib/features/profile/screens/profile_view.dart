import 'package:codegen/codegen.dart';
import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final Icon iconForward = const Icon(
      (Icons.arrow_forward_ios),
      size: 17,
      color: ColorName.primary,
    );
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/img_no_profile_pic.png'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Kullanıcı Adı',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: ColorName.primary,
              size: 25,
            ),
            title: const Text(
              'Profilim',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/profiledetail');
            },
            trailing: iconForward,
          ),
          const SizedBox(
            height: 12,
          ),
          ListTile(
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
          ),
          const SizedBox(
            height: 12,
          ),
          ListTile(
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
          ),
          const SizedBox(
            height: 12,
          ),
          ListTile(
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
          ),
          const SizedBox(
            height: 12,
          ),
          ListTile(
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
          ),
          const SizedBox(
            height: 12,
          ),
          ListTile(
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
          ),
          const SizedBox(
            height: 12,
          ),
          ListTile(
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
            onTap: () => AuthService().logOut(context),
          ),
        ],
      ),
    );
  }
}
