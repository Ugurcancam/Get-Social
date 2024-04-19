import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:etkinlikapp/core/constants/constants.dart';
import 'package:etkinlikapp/core/services/il_ilce_service.dart';
import 'package:etkinlikapp/core/widgets/custom_sizedbox_height.dart';
import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/features/event_room/domain/services/event_categories_service.dart';
import 'package:etkinlikapp/features/event_room/domain/services/event_room_service.dart';
import 'package:etkinlikapp/core/services/location_service.dart';
import 'package:etkinlikapp/features/event_room/domain/view_models/create_event_room_view_model.dart';
import 'package:etkinlikapp/features/event_room/screens/create_event_room_subview.dart';
import 'package:etkinlikapp/features/event_room/state/bloc/create_room_bloc.dart';
import 'package:etkinlikapp/features/event_room/widgets/create_room_custom_textfield.dart';
import 'package:etkinlikapp/features/event_room/widgets/create_room_custom_textfield_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

part 'create_event_room_mixin.dart';

class CreateEventRoomPage extends StatefulWidget {
  const CreateEventRoomPage({
    super.key,
  });

  @override
  State<CreateEventRoomPage> createState() => _CreateEventRoomPageState();
}

class _CreateEventRoomPageState extends State<CreateEventRoomPage> with CreateEventRoomPageMixin {
  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<UserProvider>(context).uid;
    final nameSurname = Provider.of<UserProvider>(context).namesurname;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event Room'),
      ),
      body: BlocBuilder<CreateRoomBloc, CreateRoomState>(
        bloc: _createRoomBloc,
        builder: (context, state) {
          if (state is CreateRoomLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CreateRoomFailure) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is CreateRoomSuccess) {
            final eventCategory = state.eventCategoriesData;
            final provinces = state.provinces;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    if (_currentP == null)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      Container(
                        height: 250,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: _currentP!,
                            zoom: 12,
                          ),
                          markers: {
                            Marker(
                              markerId: const MarkerId('_currentLocation'),
                              position: _currentP!,
                            ),
                          },
                          onTap: (LatLng latLng) {
                            final lat = latLng.latitude;
                            final long = latLng.longitude;
                            setState(() {
                              _currentP = latLng;
                              coordinate = '$lat,$long';
                            });
                            //Koordinatlar alındıktan sonra adresi almak için
                            getPlaceDetails(lat, long);
                          },
                        ),
                      ),
                    Container(
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
                    ),
                    const HeightBox(height: 13),
                    CustomTextFormField(width: width, height: height, hintText: 'Event Adı', controller: _roomViewModel.eventNameController),
                    const HeightBox(height: 13),
                    CustomTextFieldWithIcon(width: width, height: height, hintText: 'Event Tarihi', controller: _roomViewModel.eventDateController, icon: Icons.date_range, onPressed: _showDatePicker),
                    const SizedBox(height: 16),
                    CustomTextFieldWithIcon(width: width, height: height, hintText: 'Event Saati', controller: _roomViewModel.eventTimeController, icon: Icons.access_time, onPressed: _showTimePicker),
                    const SizedBox(height: 16),
                    CustomTextFormField(width: width, height: height, hintText: 'Adres Detayı', controller: adresAciklamasiController),
                    const SizedBox(height: 16),
                    CustomTextFormField(width: width, height: height, hintText: 'Event Açıklaması', controller: _roomViewModel.eventDescriptionController),
                    const HeightBox(height: 25),
                    CustomDropdown<String>(
                      decoration: const CustomDropdownDecoration(
                        closedFillColor: Color.fromRGBO(49, 62, 85, 0.78),
                      ),
                      hintText: 'Şehir Seçiniz',
                      items: provinces.toList(),
                      onChanged: (province) async {
                        final ilceler = await ProvinceService().getDisctricts(province);
                        setState(() {
                          ilcelerr = ilceler;
                          getir = true;
                          selectedProvince = province;
                        });
                      },
                    ),
                    const HeightBox(height: 20),
                    if (ilcelerr.isNotEmpty)
                      CustomDropdown<String>(
                        hintText: 'İlçe Seçiniz',
                        items: ilcelerr.toList(),
                        onChanged: (district) {
                          setState(() {
                            selectedDistrict = district;
                          });
                        },
                      ),
                    Container(
                      width: width,
                      height: height * 0.08,
                      child: ElevatedButton(
                        onPressed: () async {
                          await _eventRoomService.createRoom(
                            eventName: _roomViewModel.eventNameController.text,
                            eventDetail: _roomViewModel.eventDescriptionController.text,
                            eventDate: _roomViewModel.eventDateController.text,
                            eventTime: _roomViewModel.eventTimeController.text,
                            creatorUid: uid!,
                            namesurname: nameSurname!,
                            category: selectedCategoryList!,
                            coordinate: coordinate,
                            province: selectedProvince,
                            district: selectedDistrict,
                            addressDetail: adresAciklamasiController.text,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Room created successfully'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        //make a feedback if the room is created

                        child: const Text('Odayı Oluştur'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

// class CustomTextFieldWithIcon extends StatelessWidget {
//   const CustomTextFieldWithIcon({
//     super.key,
//     required this.width,
//     required this.height,
//     required CreateEventRoomViewModel roomViewModel,
//   }) : _roomViewModel = roomViewModel;

//   final double width;
//   final double height;
//   final CreateEventRoomViewModel _roomViewModel;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height * 0.08,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         color: const Color.fromRGBO(49, 62, 85, 0.78),
//       ),
//       child: Center(
//         child: Row(
//           children: [
//             Expanded(
//               flex: 3,
//               child: TextFormField(
//                 style: TextStyle(color: Colors.white),
//                 controller: _roomViewModel.eventTimeController,
//                 decoration: const InputDecoration(
//                   hintText: 'Event Saati',
//                   hintStyle: TextStyle(
//                     color: Colors.white,
//                   ),
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.only(left: 16),
//                 ),
//               ),
//             ),
//             const Spacer(),
//             Expanded(
//               child: IconButton(
//                 onPressed:() {
                  
//                 },
//                 icon: const Icon(Icons.access_time_rounded, color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomTextFormField extends StatelessWidget {
//   const CustomTextFormField({
//     super.key,
//     required this.width,
//     required this.height,
//     required CreateEventRoomViewModel roomViewModel,
//   }) : _roomViewModel = roomViewModel;

//   final double width;
//   final double height;
//   final CreateEventRoomViewModel _roomViewModel;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height * 0.08,
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color.fromRGBO(49, 62, 85, 0.78)),
//       child: Center(
//         child: TextFormField(
//           cursorColor: Colors.grey,
//           style: TextStyle(color: Colors.white),
//           keyboardType: TextInputType.emailAddress,
//           controller: _roomViewModel.eventNameController,
//           decoration: const InputDecoration(
//             hintText: 'Event Adı',
//             hintStyle: TextStyle(
//               color: Colors.white,
//             ),
//             border: InputBorder.none,
//             contentPadding: EdgeInsets.only(left: 16),
//           ),
//         ),
//       ),
//     );
//   }
// }
