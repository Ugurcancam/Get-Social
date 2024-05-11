import 'package:codegen/codegen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventDetail extends StatefulWidget {
  @override
  State<EventDetail> createState() => EventDetailState();
}

class EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Etkinlik Detayı', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset('assets/images/onboarding.jpg'),
              ),
              const SizedBox(height: 10),
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
                    Text('Eğlence', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'National Geographic Etkinliği',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 20,
                    color: ColorName.primary,
                  ),
                  const SizedBox(width: 5),
                  Text('${'event.eventDate'}, - ${'event.eventTime'}', style: TextStyle(fontSize: 18, color: Colors.black)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 20,
                    color: ColorName.primary,
                  ),
                  const SizedBox(width: 5),
                  Text('${'event.province'}, ${'event.district'}', style: TextStyle(fontSize: 18, color: Colors.black)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.group_add_outlined,
                    size: 20,
                    color: ColorName.primary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '234 Katılımcı',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text('Davet Et', style: TextStyle(fontSize: 18, color: ColorName.primary)),
                ],
              ),
              const SizedBox(height: 15),
              Text('Etkinlik Açıklaması', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(
                'National Geographic Etkinliği',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              Text('Organizatör', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/onboarding.jpg'),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'National Geographic',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'National Geographic',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
