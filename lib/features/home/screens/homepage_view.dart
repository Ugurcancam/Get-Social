import 'package:etkinlikapp/core/constants/constants.dart';
import 'package:etkinlikapp/core/services/locale_data_service.dart';
import 'package:etkinlikapp/core/widgets/custom_sizedbox_height.dart';
import 'package:etkinlikapp/core/widgets/custom_sizedbox_width.dart';
import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'homepage_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: appBarColor,
          ),
          width: width * 0.4,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.location_on,
                  color: appBar2Color,
                ),
                onPressed: () {},
              ),
              Text(
                namesurname ?? 'a',
                style: TextStyle(
                  fontSize: 17,
                  color: appBar2Color,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/createeventroom'),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://media.licdn.com/dms/image/D4D03AQGzv-BEu-WotQ/profile-displayphoto-shrink_800_800/0/1678465043617?e=1717027200&v=beta&t=DgbbG8mT7tZgRZXsadkzPYVivKsexUVqcd4iei3AuTY',
              ),
              radius: 25, // Increase the radius to make the image bigger
            ),
          ),
        ],
      ),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(75, 38, 115, 1),
              Color.fromRGBO(29, 21, 58, 1),
              Color.fromRGBO(12, 14, 35, 1),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                email ?? 'a',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: whiteColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Discover the best events',
                style: TextStyle(
                  fontSize: 17,
                  color: whiteColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SearchForEvents(width: width, height: height),
              const SizedBox(
                height: 30,
              ),
              const PopularEventsSeeAll(),
              const SizedBox(
                height: 20,
              ),
              PopularEventCard(height: height, width: width),
              const SizedBox(
                height: 20,
              ),
              const UpcomingEventsSeeAll(),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: width,
                decoration: BoxDecoration(
                  color: authContainerTextFieldColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1.5),
                      height: height * 0.12,
                      width: width * 0.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1505236858219-8359eb29e329?q=80&w=2524&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * 0.56,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Music Festival',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: whiteColor,
                                  ),
                                ),
                                HeightBox(height: height * 0.015),
                                // Container(
                                //   height: height * 0.05,
                                //   width: width * 0.14,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(5),
                                //     color: appBarColor,
                                //   ),
                                //   child: const Column(
                                //     children: [
                                //       HeightBox(height: 5),
                                //       Text(
                                //         '21',
                                //         style: TextStyle(
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 15,
                                //           color: whiteColor,
                                //         ),
                                //       ),
                                //       Text(
                                //         'Haz',
                                //         style: TextStyle(
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 15,
                                //           color: whiteColor,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                Container(
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: appBar2Color,
                                        size: 13,
                                      ),
                                      WidthBox(width: 5),
                                      Text(
                                        'Kastamonu, Merkez',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: appBar2Color,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const HeightBox(height: 15),
                          Container(
                            child: const Text(
                              '10 people joined',
                              style: TextStyle(
                                fontSize: 13,
                                color: appBar2Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingEventsSeeAll extends StatelessWidget {
  const UpcomingEventsSeeAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          'Upcoming Events',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: whiteColor,
          ),
        ),
        Spacer(),
        Text(
          'See All',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: secondaryTextColor,
          ),
        ),
      ],
    );
  }
}

class PopularEventCard extends StatelessWidget {
  const PopularEventCard({
    required this.height,
    required this.width,
    super.key,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: appBarColor,
      ),
      height: height * 0.3,
      width: width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.network(
              'https://images.unsplash.com/photo-1505236858219-8359eb29e329?q=80&w=2524&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const ListTile(
            title: Text(
              'Music Festival',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: whiteColor,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: appBar2Color,
                  size: 13,
                ),
                Text(
                  'Kastamonu',
                  style: TextStyle(
                    fontSize: 13,
                    color: appBar2Color,
                  ),
                ),
              ],
            ),
            trailing: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://media.licdn.com/dms/image/D4D03AQGzv-BEu-WotQ/profile-displayphoto-shrink_800_800/0/1678465043617?e=1717027200&v=beta&t=DgbbG8mT7tZgRZXsadkzPYVivKsexUVqcd4iei3AuTY',
              ),
              radius: 15, // Increase the radius to make the image bigger
            ),
          ),
        ],
      ),
    );
  }
}

class PopularEventsSeeAll extends StatelessWidget {
  const PopularEventsSeeAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          'Popular Events',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: whiteColor,
          ),
        ),
        Spacer(),
        Text(
          'See All',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: secondaryTextColor,
          ),
        ),
      ],
    );
  }
}

class SearchForEvents extends StatelessWidget {
  const SearchForEvents({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: buttonColor,
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.search,
            color: appBar2Color,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Search for events',
            style: TextStyle(
              fontSize: 17,
              color: appBar2Color,
            ),
          ),
        ],
      ),
    );
  }
}
