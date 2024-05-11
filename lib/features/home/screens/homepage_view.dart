import 'package:etkinlikapp/core/constants/constants.dart';
import 'package:etkinlikapp/core/services/locale_data_service.dart';
import 'package:etkinlikapp/core/widgets/custom_sizedbox_height.dart';
import 'package:etkinlikapp/core/widgets/custom_sizedbox_width.dart';
import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/features/event_room/screens/event_room_detail/event_room_detail_view.dart';
import 'package:etkinlikapp/features/home/state/bloc/home_page_bloc.dart';
import 'package:etkinlikapp/features/update_users_location/screens/update_users_location_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        } else if (state is NoEventRoomFound) {
          final user = state.user;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorName.primary,
              elevation: 0,
              leading: user.profilePhotoURL != ''
                  ? Container(
                      margin: EdgeInsets.only(left: 25),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.profilePhotoURL ?? 'https://via.placeholder.com/200',
                        ),
                        radius: 5, // Increase the radius to make the image bigger
                      ),
                    )
                  : Image.asset(
                      Assets.images.imgNoProfilePic.path,
                      width: 50,
                      height: 50,
                    ),
              title: Center(
                child: Column(
                  children: [
                    Text(
                      'Mevcut Konum',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[100],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: ColorName.button,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          user.province,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  width: width * 0.12,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[200],
                  ),
                  child: Icon(
                    Icons.notifications_active_outlined,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.images.googleIcon.path,
                  height: 200,
                  width: 200,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Bulunduğunuz ilde etkinlik bulunmamaktadır.Lütfen başka bir il seçiniz.',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else if (state is HomePageLoaded) {
          final user = state.user;
          final events = state.eventRooms;
          return Scaffold(
            backgroundColor: Colors.grey[100],
            //extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorName.primary,
              elevation: 0,
              leading: user.profilePhotoURL != ''
                  ? Container(
                      margin: EdgeInsets.only(left: 25),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.profilePhotoURL ?? 'https://via.placeholder.com/200',
                        ),
                        radius: 5, // Increase the radius to make the image bigger
                      ),
                    )
                  : Image.asset(
                      Assets.images.imgNoProfilePic.path,
                      width: 50,
                      height: 50,
                    ),
              title: Center(
                child: Column(
                  children: [
                    Text(
                      'Mevcut Konum',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[100],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: ColorName.button,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          user.province,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  width: width * 0.12,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[200],
                  ),
                  child: Icon(
                    Icons.notifications_active_outlined,
                    size: 25,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    child: Image.network(
                                      'https://source.unsplash.com/random/300x200?sig=1',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    event.eventName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: blackColor,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                        Icons.access_time,
                                        size: 16,
                                        color: ColorName.primary,
                                      ),
                                      const SizedBox(width: 5),
                                      Text('${event.eventDate}, - ${event.eventTime}', style: TextStyle(fontSize: 15, color: blackColor)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: ColorName.primary,
                                      ),
                                      const SizedBox(width: 5),
                                      Text('${event.province}, ${event.district}', style: TextStyle(fontSize: 15, color: blackColor)),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
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
                    const UpcomingEventsSeeAll(),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 190,
                      width: width * 0.87,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventRoomDetail(event: event))),
                            child: Container(
                              margin: EdgeInsets.only(right: 15),
                              height: 190,
                              width: width * 0.87,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            child: Image.network(
                                              'https://source.unsplash.com/random/200x200?sig=1',
                                              width: 100,
                                              height: 110,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            const SizedBox(height: 5),
                                            Text(
                                              event.eventName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: blackColor,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            Container(
                                              height: 25,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                color: ColorName.third,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.calendar_today,
                                                    size: 15,
                                                    color: ColorName.primary,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(event.categories, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  size: 16,
                                                  color: ColorName.primary,
                                                ),
                                                const SizedBox(width: 5),
                                                Text('${event.eventDate}, - ${event.eventTime}', style: TextStyle(fontSize: 15, color: blackColor)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  size: 16,
                                                  color: ColorName.primary,
                                                ),
                                                const SizedBox(width: 5),
                                                Text('${event.province}, ${event.district}', style: TextStyle(fontSize: 15, color: blackColor)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const CizgiliKesme(),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: ElevatedButton(
                                              onPressed: () async {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: ColorName.third,
                                                minimumSize: Size(double.infinity, 50),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text('Etkinlik Detayı', style: TextStyle(fontSize: 17, color: Colors.black)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: ElevatedButton(
                                              onPressed: () async {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: ColorName.primary,
                                                minimumSize: Size(double.infinity, 50),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text('Etkinliğe Katıl', style: TextStyle(fontSize: 17, color: Colors.white)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text('data'),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    //AlttakiCard(width: width, height: height)
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class CizgiliKesme extends StatelessWidget {
  const CizgiliKesme({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
          Expanded(child: Divider(color: Colors.grey, thickness: 1, height: 1, endIndent: 10)),
        ],
      ),
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
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            width: width,
            height: height * 0.06,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(20),
              // color: Colors.grey[200],
            ),
            child: const Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Etkinlik Ara',
                  style: TextStyle(
                    fontFamily: 'SFProRegular',
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: height * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
            child: Icon(
              Icons.filter_list_sharp,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
