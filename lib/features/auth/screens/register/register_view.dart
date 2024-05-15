import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:codegen/codegen.dart';
import 'package:etkinlikapp/core/constants/constants.dart';
import 'package:etkinlikapp/core/services/il_ilce_service.dart';
import 'package:etkinlikapp/core/widgets/custom_sizedbox_height.dart';
import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:etkinlikapp/features/auth/domain/view_models/register_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

part 'register_sub_view.dart';
part 'register_view_mixin.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with RegisterViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: registerFormKey,
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Merhaba!',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Keşfetmeye hazır mısın?',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                //Ad Soyad
                NameSurnameTextField(registerViewModel: registerViewModel, nameSurnameController: nameSurnameController),
                const SizedBox(height: 20),
                //Email
                EmailTextField(registerViewModel: registerViewModel, emailController: emailController),
                //Şifre
                const SizedBox(height: 20),
                PasswordTextField(controlPasswordVisibility: controlPasswordVisibility, isPasswordVisible: isPasswordVisible, registerViewModel: registerViewModel, passwordController: passwordController),
                //Şifre Tekrar
                const SizedBox(height: 20),
                ConfirmPasswordTextfield(controlPasswordVisibility: controlCheckPasswordVisibility, isPasswordVisible: isCheckPasswordVisible, registerViewModel: registerViewModel, checkPasswordController: checkPasswordController),
                //Yaşadığınız Şehir
                const SizedBox(height: 20),
                SizedBox(
                  width: width,
                  height: height * 0.08,
                  child: CustomDropdown<String>.search(
                    validateOnChange: true,
                    validator: (value) => value == null ? "Lütfen il seçiniz" : null,
                    decoration: CustomDropdownDecoration(
                      closedFillColor: Colors.grey[200],
                      hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                      headerStyle: TextStyle(color: Colors.black),
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
                        hintStyle: TextStyle(color: Colors.black),
                        headerStyle: TextStyle(color: Colors.black),
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
                // ProvinceTextField(width: width, height: height, provinceController: provinceController),

                //Kayıt Ol Butonu
                const SizedBox(height: 20),
                RegisterButton(
                  onPressed: () async {
                    if (registerFormKey.currentState!.validate() && valueByPasswordController == valueByCheckPasswordController) {
                      await AuthService().signUp(
                        context,
                        nameSurname: valueByNameSurnameController,
                        email: valueByEmailController,
                        password: valueByPasswordController,
                        dateOfBirth: valueByDateOfBirthController,
                        province: selectedProvince,
                        district: selectedDistrict,
                        profilePhotoUrl: '',
                      );
                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.success(
                          message: "Hesabınız başarıyla oluşturuldu.",
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                NavigateToLoginPage()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
