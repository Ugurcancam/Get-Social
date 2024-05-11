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
          color: ColorName.primary,
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
    required this.registerViewModel,
    required this.checkPasswordController,
    required this.isPasswordVisible,
    required this.controlPasswordVisibility,
    super.key,
  });

  final bool isPasswordVisible;
  final VoidCallback controlPasswordVisibility;
  final RegisterViewModel registerViewModel;
  final TextEditingController checkPasswordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: checkPasswordController,
      obscureText: !isPasswordVisible,
      validator: (value) => registerViewModel.validatePassword(checkPasswordController.text),
      decoration: InputDecoration(
        labelText: 'Şifre Tekrar',
        labelStyle: TextStyle(fontSize: 18),
        prefixIcon: const Icon(
          Icons.password_outlined,
          color: Colors.black,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: controlPasswordVisibility,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    required this.registerViewModel,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.controlPasswordVisibility,
    super.key,
  });

  final bool isPasswordVisible;
  final VoidCallback controlPasswordVisibility;
  final RegisterViewModel registerViewModel;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: !isPasswordVisible,
      validator: (value) => registerViewModel.validatePassword(passwordController.text),
      decoration: InputDecoration(
        labelText: 'Şifre',
        labelStyle: TextStyle(fontSize: 18),
        prefixIcon: const Icon(
          Icons.password_outlined,
          color: Colors.black,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: controlPasswordVisibility,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    required this.registerViewModel,
    required this.emailController,
    super.key,
  });

  final RegisterViewModel registerViewModel;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => registerViewModel.validateEmail(emailController.text),
      decoration: InputDecoration(
        labelText: 'E-Posta',
        labelStyle: TextStyle(fontSize: 18),
        prefixIcon: const Icon(
          Icons.email_outlined,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

class NameSurnameTextField extends StatelessWidget {
  const NameSurnameTextField({
    required this.registerViewModel,
    required this.nameSurnameController,
    super.key,
  });

  final RegisterViewModel registerViewModel;
  final TextEditingController nameSurnameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameSurnameController,
      validator: (value) => registerViewModel.validateNameSurname(nameSurnameController.text),
      decoration: InputDecoration(
        labelText: 'Ad Soyad',
        labelStyle: TextStyle(fontSize: 18),
        prefixIcon: const Icon(
          Icons.person_outline_rounded,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      keyboardType: TextInputType.name,
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
          text: 'Bir hesabın var mı? ',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
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
