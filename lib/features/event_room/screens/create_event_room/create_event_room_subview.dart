part of 'create_event_room_view.dart';

// final class CreateRoomButton extends StatelessWidget {
//   const CreateRoomButton({
//     super.key,
//     required this.width,
//     required this.height,
//     required EventRoomService eventRoomService,
//     required CreateEventRoomViewModel roomViewModel,
//     required this.uid,
//     required this.nameSurname,
//     required this.selectedCategoryListt,
//     required this.coordinate,
//     required this.selectedProvince,
//     required this.selectedDistrict,
//     required this.eventPlaceDescriptionController,
//   })  : _eventRoomService = eventRoomService,
//         _createEventRoomViewModel = roomViewModel;

//   final double width;
//   final double height;
//   final EventRoomService _eventRoomService;
//   final CreateEventRoomViewModel _createEventRoomViewModel;
//   final String? uid;
//   final String? nameSurname;
//   final List<String>? selectedCategoryListt;
//   final String coordinate;
//   final String selectedProvince;
//   final String selectedDistrict;
//   final TextEditingController eventPlaceDescriptionController;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height * 0.08,
//       child: ElevatedButton(
//         onPressed: () async {
//           print(selectedCategoryListt);
//           await _eventRoomService.createRoom(
//             eventName: _createEventRoomViewModel.eventNameController.text,
//             eventDetail: _createEventRoomViewModel.eventDescriptionController.text,
//             eventDate: _createEventRoomViewModel.eventDateController.text,
//             eventTime: _createEventRoomViewModel.eventTimeController.text,
//             creatorUid: uid!,
//             namesurname: nameSurname!,
//             category: selectedCategoryListt!,
//             coordinate: coordinate,
//             province: selectedProvince,
//             district: selectedDistrict,
//             addressDetail: eventPlaceDescriptionController.text,
//           );
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Room created successfully'),
//               backgroundColor: Colors.green,
//             ),
//           );
//         },
//         child: const Text('Odayı Oluştur'),
//       ),
//     );
//   }
// }

final class GoogleMapShimmerLoading extends StatelessWidget {
  const GoogleMapShimmerLoading({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: width,
        height: 250,
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }
}

class CategoryListDropdownMenu extends StatelessWidget {
  CategoryListDropdownMenu({
    super.key,
    required this.width,
    required this.eventCategory,
    required this.selectedCategoryList,
  });

  late List<String> selectedCategoryList;
  final double width;
  final List<EventCategoriesModel> eventCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: CustomDropdown<String>.multiSelect(
        decoration: const CustomDropdownDecoration(
          closedFillColor: Color.fromRGBO(49, 62, 85, 0.78),
          hintStyle: TextStyle(color: Colors.white),
          closedSuffixIcon: Icon(Icons.arrow_drop_down, color: Colors.white),
        ),
        hintText: 'Kategori Seçiniz',
        items: eventCategory.map((e) => e.name).toList(),
        onListChanged: (value) {
          selectedCategoryList = value;
        },
      ),
    );
  }
}
