import 'package:etkinlikapp/core/constants/constants.dart';
import 'package:etkinlikapp/core/services/locale_data_service.dart';
import 'package:etkinlikapp/core/widgets/custom_sizedbox_height.dart';
import 'package:etkinlikapp/core/widgets/custom_sizedbox_width.dart';
import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/features/home/state/bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:codegen/codegen.dart';

part 'homepage_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      bloc: homePageBloc,
      builder: (context, state) {
        if (state is HomePageLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomePageErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is HomePageLoaded) {
          final user = state.user;
          final events = state.eventRooms;
          return Scaffold(
            backgroundColor: Colors.grey[100],
            //extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  children: [
                    if (user.profilePhotoURL != '')
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.profilePhotoURL ?? 'https://via.placeholder.com/200',
                        ),
                        radius: 25, // Increase the radius to make the image bigger
                      )
                    else
                      Image.asset(
                        Assets.images.imgNoProfilePic.path,
                        width: 50,
                        height: 50,
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hoş Geldin,', style: const TextStyle(fontSize: 17, color: Colors.black)),
                        Text(
                          user.namesurname,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: ColorName.buttonBorder),
                    color: ColorName.buttonBackground,
                  ),
                  width: width * 0.4,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.location_on,
                          color: ColorName.buttonText,
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        user.province,
                        style: const TextStyle(
                          fontSize: 17,
                          color: ColorName.buttonText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(right: 20, left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
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
                  Container(
                    height: height * 0.35,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return Container(
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          height: height * 0.35,
                          width: width * 0.65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1505236858219-8359eb29e329?q=80&w=2524&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(event.eventName, style: TextStyle(fontSize: 18, color: blackColor, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_month_rounded, color: Colors.black, size: 20),
                                    Text('${event.eventDate},${event.eventTime}', style: TextStyle(fontSize: 16, color: Colors.black)),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    Text(
                                      '${event.province}, ${event.district}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  //PopularEventCard(height: height, width: width),
                  const SizedBox(
                    height: 20,
                  ),
                  //const UpcomingEventsSeeAll(),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  //AlttakiCard(width: width, height: height)
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class AlttakiCard extends StatelessWidget {
  const AlttakiCard({
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
                          color: blackColor,
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
                      //           color: blackColor,
                      //         ),
                      //       ),
                      //       Text(
                      //         'Haz',
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 15,
                      //           color: blackColor,
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
                              color: Colors.black,
                              size: 13,
                            ),
                            WidthBox(width: 5),
                            Text(
                              'Kastamonu, Merkez',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
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
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
          'Yaklaşan Etkinlikler',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: blackColor,
          ),
        ),
        Spacer(),
        Text(
          'Tümünü Gör',
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
        color: Colors.white,
      ),
      height: height * 0.35,
      width: width * 0.65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Image.network(
              'https://images.unsplash.com/photo-1505236858219-8359eb29e329?q=80&w=2524&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text('Kitap Okuma Etkinliği', style: TextStyle(fontSize: 18, color: blackColor, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Row(
              children: [
                Icon(Icons.calendar_month_rounded, color: Colors.black, size: 20),
                Text('21 Haziran, 13:00', style: TextStyle(fontSize: 16, color: Colors.black)),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.black,
                  size: 20,
                ),
                Text(
                  'Kastamonu, Merkez',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          // const ListTile(
          //   title: Text(
          //     'Music Festival',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 15,
          //       color: blackColor,
          //     ),
          //   ),
          //   subtitle: Row(
          //     children: [
          //       Icon(
          //         Icons.location_on,
          //         color: Colors.black,
          //         size: 13,
          //       ),
          //       Text(
          //         'Kastamonu',
          //         style: TextStyle(
          //           fontSize: 13,
          //           color: Colors.black,
          //         ),
          //       ),
          //     ],
          //   ),
          //   trailing: CircleAvatar(
          //     backgroundImage: NetworkImage(
          //       'https://media.licdn.com/dms/image/D4D03AQGzv-BEu-WotQ/profile-displayphoto-shrink_800_800/0/1678465043617?e=1717027200&v=beta&t=DgbbG8mT7tZgRZXsadkzPYVivKsexUVqcd4iei3AuTY',
          //     ),
          //     radius: 15, // Increase the radius to make the image bigger
          //   ),
          // ),
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
          'Yaklaşan Etkinlikler',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: blackColor,
          ),
        ),
        Spacer(),
        Text(
          'Tümünü Gör',
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
        color: Colors.grey[200],
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Hangi etkinliğe katılmak istersin?',
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
