import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:etkinlikapp/core/constants/constants.dart';
import 'package:etkinlikapp/core/services/il_ilce_service.dart';
import 'package:etkinlikapp/core/widgets/custom_sizedbox_height.dart';
import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:etkinlikapp/features/auth/domain/view_models/register_view_model.dart';
import 'package:flutter/material.dart';

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
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/register_background.jpg',
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.10),
                  const Text(
                    'Merhaba!',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Keşfetmeye hazır mısın?',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Ad Soyad
                  NameSurnameTextField(width: width, height: height, registerViewModel: registerViewModel, nameSurnameController: nameSurnameController),
                  const SizedBox(height: 20),
                  //Email
                  EmailTextField(width: width, height: height, registerViewModel: registerViewModel, emailController: emailController),
                  //Şifre
                  const SizedBox(height: 20),
                  PasswordTextField(width: width, height: height, registerViewModel: registerViewModel, passwordController: passwordController),
                  //Şifre Tekrar
                  const SizedBox(height: 20),
                  ConfirmPasswordTextfield(width: width, height: height, registerViewModel: registerViewModel, checkPasswordController: checkPasswordController),
                  //Yaşadığınız Şehir
                  const SizedBox(height: 20),
                  Container(
                    width: width * 0.82,
                    height: height * 0.08,
                    child: CustomDropdown<String>(
                      validateOnChange: true,
                      // Function to validate if the current selected item is valid or not
                      validator: (value) => value == null ? "Lütfen il seçiniz" : null,
                      decoration: const CustomDropdownDecoration(
                        closedFillColor: Color.fromRGBO(49, 62, 85, 0.78),
                        hintStyle: TextStyle(color: thirdTextColor),
                        headerStyle: TextStyle(color: thirdTextColor),
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
                  const HeightBox(height: 20),
                  if (ilcelerr.isNotEmpty)
                    Container(
                      width: width * 0.82,
                      height: height * 0.08,
                      child: CustomDropdown<String>(
                        validateOnChange: true,
                        // Function to validate if the current selected item is valid or not
                        validator: (value) => value == null ? "Lütfen ilçe seçiniz" : null,
                        decoration: const CustomDropdownDecoration(
                          closedFillColor: Color.fromRGBO(49, 62, 85, 0.78),
                          hintStyle: TextStyle(color: thirdTextColor),
                          headerStyle: TextStyle(color: thirdTextColor),
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
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  NavigateToLoginPage()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
