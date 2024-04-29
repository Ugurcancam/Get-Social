part of 'register_view.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    required this.onPressed,
    super.key,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 320,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromRGBO(95, 25, 242, 1),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 8),
            Text(
              'Kayıt Ol',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProvinceTextField extends StatelessWidget {
  const ProvinceTextField({
    required this.width,
    required this.height,
    required this.provinceController,
    super.key,
  });

  final double width;
  final double height;
  final TextEditingController provinceController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.82,
      height: height * 0.08,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: authContainerTextFieldColor),
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.name,
          controller: provinceController,
          decoration: const InputDecoration(
            hintText: 'Yaşadığınız Şehir',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 16),
          ),
        ),
      ),
    );
  }
}

class ConfirmPasswordTextfield extends StatelessWidget {
  const ConfirmPasswordTextfield({
    required this.width,
    required this.height,
    required this.registerViewModel,
    required this.checkPasswordController,
    super.key,
  });

  final double width;
  final double height;
  final RegisterViewModel registerViewModel;
  final TextEditingController checkPasswordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.82,
      height: height * 0.08,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: authContainerTextFieldColor),
      child: Center(
        child: TextFormField(
          style: TextStyle(color: thirdTextColor),
          validator: registerViewModel.validatePassword,
          controller: checkPasswordController,
          decoration: const InputDecoration(
            hintText: 'Şifre Tekrar',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 16),
          ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    required this.width,
    required this.height,
    required this.registerViewModel,
    required this.passwordController,
    super.key,
  });

  final double width;
  final double height;
  final RegisterViewModel registerViewModel;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.82,
      height: height * 0.08,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: authContainerTextFieldColor),
      child: Center(
        child: TextFormField(
          style: TextStyle(color: thirdTextColor),
          validator: registerViewModel.validatePassword,
          controller: passwordController,
          decoration: const InputDecoration(
            hintText: 'Şifre',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 16),
          ),
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    required this.width,
    required this.height,
    required this.registerViewModel,
    required this.emailController,
    super.key,
  });

  final double width;
  final double height;
  final RegisterViewModel registerViewModel;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.82,
      height: height * 0.08,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: authContainerTextFieldColor),
      child: Center(
        child: TextFormField(
          style: TextStyle(color: thirdTextColor),
          keyboardType: TextInputType.emailAddress,
          validator: registerViewModel.validateEmail,
          controller: emailController,
          decoration: const InputDecoration(
            hintText: 'E Posta',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 16),
          ),
        ),
      ),
    );
  }
}

class NameSurnameTextField extends StatelessWidget {
  const NameSurnameTextField({
    required this.width,
    required this.height,
    required this.registerViewModel,
    required this.nameSurnameController,
    super.key,
  });

  final double width;
  final double height;
  final RegisterViewModel registerViewModel;
  final TextEditingController nameSurnameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.82,
      height: height * 0.08,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: authContainerTextFieldColor),
      child: Center(
        child: TextFormField(
          style: TextStyle(color: thirdTextColor),
          keyboardType: TextInputType.name,
          validator: registerViewModel.validateNameSurname,
          controller: nameSurnameController,
          decoration: const InputDecoration(
            hintText: 'Ad Soyad',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 16),
          ),
        ),
      ),
    );
  }
}

class NavigateToLoginPage extends StatelessWidget {
  const NavigateToLoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/login'),
      child: const Text.rich(
        TextSpan(
          text: 'Bir hesabınız var mı? ',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'Giriş Yap',
              style: TextStyle(
                fontSize: 18,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
