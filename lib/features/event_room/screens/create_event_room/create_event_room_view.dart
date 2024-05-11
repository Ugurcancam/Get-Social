import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:codegen/gen/assets.gen.dart';
import 'package:codegen/gen/colors.gen.dart';
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
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

part 'create_event_room_mixin.dart';
part 'create_event_room_subview.dart';

class CreateEventRoomPage extends StatefulWidget {
  final String coordinate;
  final String selectedProvince;
  final String selectedDistrict;
  final String addressDetail;
  const CreateEventRoomPage({
    required this.coordinate,
    required this.selectedProvince,
    required this.selectedDistrict,
    required this.addressDetail,
    super.key,
  });

  @override
  State<CreateEventRoomPage> createState() => _CreateEventRoomPageState();
}

class _CreateEventRoomPageState extends State<CreateEventRoomPage> with CreateEventRoomPageMixin {
  bool _isLoading = false;
  bool _isLoadingComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etkinlik Odası Oluştur'),
      ),
      body: BlocBuilder<CreateRoomBloc, CreateRoomState>(
        bloc: _createRoomBloc,
        builder: (context, state) {
          if (_isLoading) {
            return Center(
              child: LottieBuilder.asset(
                Assets.json.animation.animationLoading.path,
                repeat: _isLoading,
                width: 200,
                height: 200,
                onLoaded: (p0) => navigateToHomeOnComplete,
              ),
            );
          }
          if (_isLoadingComplete) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    Assets.json.animation.animationLoadingSuccess.path,
                    repeat: false,
                    width: 200,
                    height: 200,
                    onLoaded: (p0) async {
                      await navigateToHomeOnComplete();
                    },
                  ),
                  const HeightBox(height: 20),
                  const Text('Oda Oluşturuldu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }
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
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const HeightBox(height: 13),
                    CustomTextFormField(icon: Icons.abc, hintText: 'Event Adı', controller: _createEventRoomViewModel.eventNameController),
                    const HeightBox(height: 13),
                    CustomTextFormField(icon: Icons.description_outlined, hintText: 'Event Açıklaması', controller: _createEventRoomViewModel.eventDescriptionController),
                    const HeightBox(height: 13),
                    CustomDropdown(
                      validator: (value) => value == null ? "Lütfen Kategori Seçiniz" : null,
                      hintText: 'Kategori',
                      decoration: CustomDropdownDecoration(
                        closedFillColor: Colors.grey[200],
                        hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                        headerStyle: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      items: eventCategory.map((e) => e.name).toList(),
                      onChanged: (value) {
                        selectedCategory = value;
                        print(selectedCategory);
                      },
                    ),
                    const HeightBox(height: 13),
                    CustomTextFieldWithIcon(width: width, height: height, hintText: 'Event Tarihi', controller: _createEventRoomViewModel.eventDateController, icon: Icons.date_range, onPressed: _selectDate),
                    const SizedBox(height: 13),
                    CustomTextFieldWithIcon(width: width, height: height, hintText: 'Event Saati', controller: _createEventRoomViewModel.eventTimeController, icon: Icons.access_time, onPressed: _selectTime),
                    const HeightBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await _eventRoomService.createRoom(
                          eventName: _createEventRoomViewModel.eventNameController.text,
                          eventDetail: _createEventRoomViewModel.eventDescriptionController.text,
                          eventDate: _createEventRoomViewModel.eventDateController.text,
                          eventTime: _createEventRoomViewModel.eventTimeController.text,
                          creatorUid: uid!,
                          namesurname: nameSurname!,
                          category: selectedCategory,
                          coordinate: widget.coordinate,
                          province: widget.selectedProvince,
                          district: widget.selectedDistrict,
                          addressDetail: widget.addressDetail,
                        );
                        setState(() {
                          _isLoading = false;
                          _isLoadingComplete = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorName.primary,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Odayı Oluştur', style: TextStyle(fontSize: 18, color: Colors.white)),
                    )
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
