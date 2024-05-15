import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:etkinlikapp/core/services/il_ilce_service.dart';
import 'package:etkinlikapp/features/profile/domain/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateUsersLocationView extends StatefulWidget {
  const UpdateUsersLocationView({super.key});

  @override
  State<UpdateUsersLocationView> createState() => _UpdateUsersLocationViewState();
}

class _UpdateUsersLocationViewState extends State<UpdateUsersLocationView> {
  //Variables for selecting Province and District
  List<String> ilcelerr = [];
  late String selectedProvince;
  late String selectedDistrict;

  // Get logged in users uid
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Users Location'),
      ),
      body: FutureBuilder(
        future: ProvinceService().getProvinces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            final provinces = snapshot.data as List<String>;
            return Column(
              children: [
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
                    print(selectedProvince);
                  },
                ),
                const SizedBox(height: 20),
                if (ilcelerr.isNotEmpty)
                  CustomDropdown<String>(
                    hintText: 'İlçe Seçiniz',
                    items: ilcelerr.toList(),
                    onChanged: (district) {
                      setState(() {
                        selectedDistrict = district;
                      });
                      print(selectedDistrict);
                    },
                  ),
                ElevatedButton(
                  onPressed: () => UserService().updateUserLocation(uid, selectedProvince, selectedDistrict),
                  child: Text('Kaydet'),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
