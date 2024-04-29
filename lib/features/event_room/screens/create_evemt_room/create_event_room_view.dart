import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:etkinlikapp/core/manager/location_permission_manager.dart';
import 'package:etkinlikapp/core/services/il_ilce_service.dart';
import 'package:etkinlikapp/core/services/location_service.dart';
import 'package:etkinlikapp/core/widgets/custom_sizedbox_height.dart';
import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_categories_model.dart';
import 'package:etkinlikapp/features/event_room/domain/services/event_room_service.dart';
import 'package:etkinlikapp/features/event_room/domain/view_models/create_event_room_view_model.dart';
import 'package:etkinlikapp/features/event_room/state/bloc/create_room/create_room_bloc.dart';
import 'package:etkinlikapp/features/event_room/widgets/create_room_custom_textfield.dart';
import 'package:etkinlikapp/features/event_room/widgets/create_room_custom_textfield_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

part 'create_event_room_mixin.dart';
part 'create_event_room_subview.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etkinlik Odası Oluştur'),
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
                      GoogleMapShimmerLoading(width: width)
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
                              selectedPlaceCoordinate = '$lat,$long';
                            });
                            //Koordinatlar alındıktan sonra adresi almak için
                            LocationService().getPlaceDetails(lat, long, setAddress);
                          },
                        ),
                      ),
                    const HeightBox(height: 13),
                    CustomTextFormField(width: width, height: height, hintText: 'Event Adı', controller: _createEventRoomViewModel.eventNameController),
                    const HeightBox(height: 13),
                    CustomTextFormField(width: width, height: height, hintText: 'Event Açıklaması', controller: _createEventRoomViewModel.eventDescriptionController),
                    const HeightBox(height: 13),
                    CategoryListDropdownMenu(width: width, eventCategory: eventCategory, selectedCategoryList: selectedCategoryList!),
                    const HeightBox(height: 13),
                    CustomTextFieldWithIcon(width: width, height: height, hintText: 'Event Tarihi', controller: _createEventRoomViewModel.eventDateController, icon: Icons.date_range, onPressed: _selectDate),
                    const SizedBox(height: 13),
                    CustomTextFieldWithIcon(width: width, height: height, hintText: 'Event Saati', controller: _createEventRoomViewModel.eventTimeController, icon: Icons.access_time, onPressed: _selectTime),
                    const SizedBox(height: 13),
                    CustomTextFormField(width: width, height: height, hintText: 'Adres Detayı', controller: _createEventRoomViewModel.eventPlaceDescriptionController),
                    const SizedBox(height: 13),
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
                    CreateRoomButton(width: width, height: height, eventRoomService: _eventRoomService, roomViewModel: _createEventRoomViewModel, uid: uid, nameSurname: nameSurname, selectedCategoryList: selectedCategoryList, coordinate: selectedPlaceCoordinate, selectedProvince: selectedProvince, selectedDistrict: selectedDistrict, eventPlaceDescriptionController: _createEventRoomViewModel.eventPlaceDescriptionController),
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
