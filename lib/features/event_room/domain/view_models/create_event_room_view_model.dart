import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

final class CreateEventRoomViewModel {
  // Controllers for Textfield
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDescriptionController = TextEditingController();
  final TextEditingController eventCategoryController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();
  final TextEditingController eventTimeController = TextEditingController();
  final TextEditingController eventPlaceDescriptionController = TextEditingController();
  //Controller for Location
  final Location locationController = Location();

  // For selecting Date
  Future<void> selectDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: DateTime.now(),
    );

    if (selectedDate != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
      eventDateController.text = formattedDate;
    }
  }

  // For selecting Time
  Future<void> selectTime(BuildContext context) async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        final formattedTime = value.format(context);
        eventTimeController.text = formattedTime;
      }
    });
  }
}
