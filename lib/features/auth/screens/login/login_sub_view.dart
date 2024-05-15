part of 'login_view.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    required this.emaillController,
    required this.loginViewModel,
    super.key,
  });

  final TextEditingController emaillController;
  final LoginViewModel loginViewModel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emaillController,
      validator: (value) => loginViewModel.validateEmail(emaillController.text),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(fontSize: 18),
        prefixIcon: Icon(
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
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    required this.passworddController,
    required this.loginViewModel,
    required this.isPasswordVisible,
    required this.controlPasswordVisibility,
    super.key,
  });

  final VoidCallback controlPasswordVisibility;
  final TextEditingController passworddController;
  final LoginViewModel loginViewModel;
  final bool isPasswordVisible;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passworddController,
      validator: (value) => loginViewModel.validatePassword(passworddController.text),
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Şifre',
        labelStyle: TextStyle(fontSize: 18),
        prefixIcon: Icon(
          Icons.lock_outline_rounded,
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

class LoginButton extends StatelessWidget {
  const LoginButton({
    required this.emailText,
    required this.passwordText,
    required this.loginFormKey,
    super.key,
  });

  final String emailText;
  final String passwordText;
  final GlobalKey<FormState> loginFormKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (loginFormKey.currentState!.validate()) {
          // Show loading widget for 2 seconds
          final loadingCompleter = Completer<void>();
          Timer(const Duration(seconds: 2), loadingCompleter.complete);
          showLoadingAnimation(context);

          // Execute sign-in logic after delay
          await loadingCompleter.future;
          await AuthService().signIn(context, email: emailText, password: passwordText);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text('Giriş Yap', style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}

class RememberMeAndForgotPassword extends StatefulWidget {
  final void Function(bool) onRememberMeChanged;
  final VoidCallback onForgotPasswordPressed;
  final bool isRememberMeChecked;

  const RememberMeAndForgotPassword({
    required this.onRememberMeChanged,
    required this.onForgotPasswordPressed,
    required this.isRememberMeChecked,
    super.key,
  });

  @override
  _RememberMeAndForgotPasswordState createState() => _RememberMeAndForgotPasswordState();
}

class _RememberMeAndForgotPasswordState extends State<RememberMeAndForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Switch(
              activeColor: ColorName.primary,
              value: true,
              onChanged: (bool value1) {},
            ),
            const Text(
              'Beni Hatırla',
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
        TextButton(
          onPressed: widget.onForgotPasswordPressed,
          child: Text(
            'Şifremi Unuttum?',
            style: TextStyle(fontSize: 17, color: ColorName.primary),
          ),
        ),
      ],
    );
  }
}

class DividerWithText extends StatelessWidget {
  const DividerWithText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 0.5,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 25),
        Text(
          'veya',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
        SizedBox(width: 25),
        Expanded(
          child: Divider(
            thickness: 0.5,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}

class OtherLoginOptions extends StatelessWidget {
  const OtherLoginOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LoginOptionsWidget(
          path: Assets.images.googleIcon.path,
        ),
        LoginOptionsWidget(
          path: Assets.images.appleIcon.path,
        ),
      ],
    );
  }
}

class NavigateToRegister extends StatelessWidget {
  const NavigateToRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hesabın yok mu?',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/register'),
          child: Text(
            'Kayıt Ol',
            style: TextStyle(
              color: ColorName.primary,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

void showForgotPasswordBottomSheet(BuildContext context) {
  final forgotPasswordEmailController = TextEditingController();
  showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: ColorName.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Şifremi Unuttum',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                'Şifrenizi sıfırlamak için e-posta adresinizi girin. Sıfırlama linkini e-posta adresinize göndereceğiz.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.82,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: TextFormField(
                    controller: forgotPasswordEmailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'E posta adresi',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  await AuthService().resetPassword(context, email: forgotPasswordEmailController.value.text);
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.success(
                      message: "Şifre sıfırlama bağlantısı e posta adresinize gönderildi.",
                    ),
                  );
                },
                child: Container(
                  width: 320,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Text(
                      'Gönder',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}

void showLoadingAnimation(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // Prevent user from dismissing while loading
    builder: (context) => Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: const Color(0xFF1A1A3F),
        rightDotColor: const Color(0xFFEA3799),
        size: 200,
      ),
    ),
  );
}
