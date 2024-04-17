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
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Create Event Room'),
      ),
      body: _currentP == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: FutureBuilder(
                future: _eventCategoriesService.getEventCategories(),
                builder: (context, snapshot) {
                  final eventCategoryData = snapshot.data!;
                  return Column(
                    children: [
                      Container(
                        height: 250,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: _currentP!,
                            zoom: 12,
                          ),
                          markers: {
                            Marker(
                              markerId: MarkerId('_currentLocation'),
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
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CustomDropdown<String>.multiSelect(
                              hintText: 'Kategori Seçiniz',
                              items: eventCategoryData.map((e) => e.name).toList(),
                              onListChanged: (value) {
                                selectedCategoryList = value;
                              },
                            ),
                            TextField(
                              controller: _roomViewModel.eventNameController,
                              decoration: const InputDecoration(
                                labelText: 'Event Adı',
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextField(
                              controller: _roomViewModel.eventTimeController,
                              decoration: const InputDecoration(
                                labelText: 'Event Zamanı',
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: adresAciklamasiController,
                              decoration: InputDecoration(
                                hintText: 'Adres Açıklaması',
                                hintStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.30,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0.98,
                                    color: Colors.black.withOpacity(0.20000000298023224),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.red),
                                ),
                                errorStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Bu alan boş bırakılamaz!";
                                }

                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 150,
                        child: FutureBuilder(
                          future: IlIlceService().getIller(),
                          builder: (context, snapshot) {
                            final cities = snapshot.data!;
                            return Column(
                              children: [
                                CustomDropdown<String>(
                                  hintText: 'Şehir Seçiniz',
                                  items: cities.toList(),
                                  onChanged: (province) async {
                                    final ilceler = await IlIlceService().getIlceler(province);
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
                                  )
                              ],
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await _eventRoomService.createRoom(
                            eventName: _roomViewModel.eventNameController.text,
                            eventDate: _roomViewModel.eventTimeController.text,
                            creatorUid: uid!,
                            namesurname: nameSurname!,
                            category: selectedCategoryList!,
                            coordinate: coordinate,
                            province: selectedProvince,
                            district: selectedDistrict,
                            addressDetail: adresAciklamasiController.text,
                          );
                        },
                        child: const Text('Odayı Oluştur'),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
