import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:etkinlikapp/features/profile/screens/users_event_rooms_view.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_image.png'),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ListTile(
            leading: Icon(Icons.person), // Add icon to the leading property
            title: Text('My Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profiledetail');
            },
          ),
          const SizedBox(
            height: 25,
          ),
          ListTile(
            leading: Icon(Icons.event), // Add icon to the leading property
            title: Text('My Event Rooms'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserEventRooms()));
            },
          ),
          const SizedBox(
            height: 25,
          ),
          ListTile(
            leading: Icon(Icons.logout), // Add icon to the leading property
            title: Text('Log Out'),
            onTap: () {
              AuthService().signOut(context);
              // Handle Log Out option
            },
          ),
        ],
      ),
    );
  }
}
