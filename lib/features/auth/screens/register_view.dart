import 'package:etkinlikapp/core/constants/constants.dart';
import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:etkinlikapp/features/auth/domain/view_models/register_view_model.dart';
import 'package:etkinlikapp/features/auth/screens/register_view_mixin.dart';
import 'package:flutter/material.dart';

part 'register_sub_view.dart';

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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                ProvinceTextField(width: width, height: height, provinceController: provinceController),

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
                        province: valueByProvinceController,
                      );
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
