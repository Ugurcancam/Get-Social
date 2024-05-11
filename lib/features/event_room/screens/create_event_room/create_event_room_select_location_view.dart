import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:etkinlikapp/core/manager/location_permission_manager.dart';
import 'package:etkinlikapp/core/services/il_ilce_service.dart';
import 'package:etkinlikapp/core/services/location_service.dart';
import 'package:etkinlikapp/core/widgets/custom_sizedbox_height.dart';
import 'package:etkinlikapp/features/event_room/screens/create_event_room/create_event_room_view.dart';
import 'package:etkinlikapp/features/event_room/state/bloc/create_room/create_room_bloc.dart';
import 'package:etkinlikapp/features/event_room/widgets/create_room_custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shimmer/shimmer.dart';

part 'create_event_room_select_location_mixin.dart';

class CreateEventRoomSelectLocationView extends StatefulWidget {
  const CreateEventRoomSelectLocationView({
    super.key,
  });

  @override
  State<CreateEventRoomSelectLocationView> createState() => _CreateEventRoomSelectLocationViewState();
}

class _CreateEventRoomSelectLocationViewState extends State<CreateEventRoomSelectLocationView> with CreateEventRoomSelectLocationViewMixin {
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
            final provinces = state.provinces;
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    if (_currentP == null)
                      Shimmer.fromColors(
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
                      )
                    else
                      Container(
                        height: 250,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: _currentP!,
                            zoom: 17,
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
                            _locationService.getPlaceDetails(lat, long, setAddress);
                          },
                        ),
                      ),
                    const SizedBox(height: 13),
                    CustomDropdown<String>(
                      validateOnChange: true,
                      validator: (value) => value == null ? "Lütfen il seçiniz" : null,
                      decoration: CustomDropdownDecoration(
                        closedFillColor: Colors.grey[200],
                        hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                        headerStyle: TextStyle(color: Colors.black, fontSize: 18),
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
                    const HeightBox(height: 10),
                    if (ilcelerr.isNotEmpty)
                      Container(
                        width: width,
                        height: height * 0.08,
                        child: CustomDropdown<String>(
                          // Function to validate if the current selected item is valid or not
                          validator: (value) => value == null ? "Lütfen ilçe seçiniz" : null,
                          decoration: CustomDropdownDecoration(
                            closedFillColor: Colors.grey[200],
                            hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                            headerStyle: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          hintText: 'İlçe Seçiniz',
                          items: ilcelerr.toList(),
                          onChanged: (district) {
                            setState(() {
                              selectedDistrict = district;
                            });
                          },
                        ),
                      ),
                    const HeightBox(height: 10),
                    CustomTextFormField(icon: Icons.near_me_outlined, hintText: 'Adres Detayı', controller: eventPlaceDescriptionController),
                    Container(
                      width: 50,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue,
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateEventRoomPage(
                              addressDetail: eventPlaceDescriptionController.text,
                              coordinate: selectedPlaceCoordinate,
                              selectedDistrict: selectedDistrict,
                              selectedProvince: selectedProvince,
                            ),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
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
