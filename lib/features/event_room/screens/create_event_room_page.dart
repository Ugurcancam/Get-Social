import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_categories_model.dart';
import 'package:etkinlikapp/features/event_room/domain/services/event_categories_service.dart';
import 'package:etkinlikapp/features/event_room/domain/services/event_room_service.dart';
import 'package:etkinlikapp/features/event_room/domain/view_models/event_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEventRoomPage extends StatelessWidget {
  CreateEventRoomPage({
    super.key,
  });

  final RoomViewModel _roomViewModel = RoomViewModel();
  final EventCategoriesService _eventCategoriesService = EventCategoriesService();
  final EventRoomService _eventRoomService = EventRoomService();

  List<String>? categoryList;

  @override
  Widget build(BuildContext context) {
    String? uid = Provider.of<UserProvider>(context).uid;
    String? nameSurname = Provider.of<UserProvider>(context).namesurname;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Create Event Room'),
      ),
      body: FutureBuilder(
          future: _eventCategoriesService.getEventCategories(),
          builder: (context, snapshot) {
            List<EventCategoriesModel> eventCategoryData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomDropdown<String>.multiSelect(
                    items: eventCategoryData.map((e) => e.name).toList(),
                    onListChanged: (value) {
                      categoryList = value;
                      print(categoryList);
                    },
                  ),
                  TextField(
                    controller: _roomViewModel.eventNameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _roomViewModel.eventTimeController,
                    decoration: const InputDecoration(
                      labelText: 'Time',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      _eventRoomService.createRoom(
                        eventName: _roomViewModel.eventNameController.text,
                        eventDate: _roomViewModel.eventTimeController.text,
                        creatorUid: uid!,
                        namesurname: nameSurname!,
                        category: categoryList!,
                      );
                    },
                    child: const Text('Create Room'),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
