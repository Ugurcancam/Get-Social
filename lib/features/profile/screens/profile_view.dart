import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:etkinlikapp/features/profile/screens/users_event_rooms_view.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final Icon iconForward = Icon(
      (Icons.arrow_forward_ios),
      size: 17,
    );
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(radius: 50, backgroundImage: NetworkImage('https://source.unsplash.com/random/200x200?sig=1')),
            title: Text('Turan Kaya', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            subtitle: Text('turankaya@gmail.com'),
          ),
          const SizedBox(
            height: 25,
          ),
          ListTile(
            leading: Text('Hesabım', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text('Profilim'),
            onTap: () {
              Navigator.pushNamed(context, '/profiledetail');
            },
            trailing: iconForward,
          ),
          ListTile(
            title: Text('Etkinlik Odalarım'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserEventRooms()));
            },
            trailing: iconForward,
          ),
          const SizedBox(
            height: 25,
          ),
          ListTile(
            leading: Text('Ayarlar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text('Şehir'),
            trailing: iconForward,
          ),
          ListTile(
            title: Text('Dil'),
            trailing: iconForward,
          ),
          const SizedBox(
            height: 25,
          ),
          ListTile(
            leading: Text('Destek', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text('Yardım Merkezi'),
            onTap: () {
              // Handle Help option
            },
            trailing: iconForward,
          ),
          ListTile(
            title: Text('Geribildirim'),
            onTap: () {
              // Handle Feedback option
            },
            trailing: iconForward,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            margin: EdgeInsets.only(top: 25, left: 15, right: 15),
            child: TextButton(
              onPressed: () {
                AuthService().logOut(context);
              },
              child: Text('Çıkış Yap', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
