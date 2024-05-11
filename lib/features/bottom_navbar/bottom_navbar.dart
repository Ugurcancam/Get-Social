import 'package:codegen/codegen.dart';
import 'package:etkinlikapp/features/categories/screens/category_view.dart';
import 'package:etkinlikapp/features/event_room/screens/create_event_room/create_event_room_select_location_view.dart';
import 'package:etkinlikapp/features/home/screens/homepage_view.dart';
import 'package:etkinlikapp/features/profile/screens/profile_view.dart';
import 'package:etkinlikapp/features/users_events/screens/users_events_view.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0; // Track the selected index

  final List<Widget> _pages = [
    const HomePage(),
    const CategoryView(),
    const CreateEventRoomSelectLocationView(),
    const UsersEventsView(),
    const Profile(), // Replace with your Profile page widget
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.grey[400],
            activeColor: ColorName.primary,
            tabBackgroundColor: Colors.grey[100]!,
            padding: const EdgeInsets.all(16),
            gap: 1,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Ana Sayfa',
              ),
              GButton(
                icon: Icons.list_alt_rounded,
                text: 'Kategoriler',
              ),
              GButton(
                icon: Icons.add,
                //  text: 'Search',
              ),
              GButton(
                icon: Icons.event_note_outlined,
                text: 'Etkinliklerim',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profilim',
              ),
            ],
            selectedIndex: _selectedIndex, // Set the selected index
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
      body: _pages.elementAt(_selectedIndex), // Display the selected page
    );
  }
}
