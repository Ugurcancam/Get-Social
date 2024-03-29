import 'package:etkinlikapp/features/categories/screens/category_view.dart';
import 'package:etkinlikapp/features/event_room/screens/event_rooms_view.dart';
import 'package:etkinlikapp/features/home/screens/HomePage.dart';
import 'package:etkinlikapp/features/profile/screens/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected index

  final List<Widget> _pages = [
    IlkSayfa(),
    const CategoryView(),
    const EventRooms(),
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
            color: Color.fromRGBO(120, 177, 182, 1),
            activeColor: Colors.white,
            tabBackgroundColor: Color.fromRGBO(120, 177, 182, 1),
            padding: const EdgeInsets.all(16),
            gap: 1,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.favorite,
                text: 'Favourite',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
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
