part of 'login_view.dart';

class BuildPasswordTextField extends StatelessWidget {
  const BuildPasswordTextField({
    required this.width,
    required this.height,
    required this.isPasswordVisible,
    required this.passwordController,
    required this.loginViewModel,
    required this.onPressed,
    super.key,
  });
  final VoidCallback onPressed;
  final double width;
  final double height;
  final bool isPasswordVisible;
  final TextEditingController passwordController;
  final LoginViewModel loginViewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.82,
      height: height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(49, 62, 85, 0.78),
      ),
      child: Center(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                style: TextStyle(color: thirdTextColor),
                obscureText: !isPasswordVisible,
                controller: passwordController,
                validator: loginViewModel.validatePassword,
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
            const Spacer(),
            Expanded(
              child: IconButton(
                onPressed: onPressed,
                icon: isPasswordVisible ? const Icon(Icons.visibility, color: Colors.white) : const Icon(Icons.visibility_off, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showForgotPasswordBottomSheet(context),
      child: Container(
        alignment: Alignment.center,
        child: const Text(
          'Şifremi Unuttum',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

void showForgotPasswordBottomSheet(BuildContext context) {
  final TextEditingController forgotPasswordEmailController = TextEditingController();
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.sizeOf(context).height * 0.5,
        color: Colors.deepPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Şifremi Unuttum', style: TextStyle(fontSize: 24, color: Colors.white)),
            const SizedBox(height: 20),
            const Text('Şifrenizi sıfırlamak için e-posta adresinizi girin.Sıfırlama linkini e-posta adresinize göndereceğiz.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.82,
              height: MediaQuery.sizeOf(context).height * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.transparent,
              ),
              child: Center(
                child: TextFormField(
                  controller: forgotPasswordEmailController,
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
                      borderSide: const BorderSide(color: Colors.white), // Seçiliyken border rengi
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
              onTap: () => AuthService().resetPassword(context, email: forgotPasswordEmailController.value.text),
              child: Container(
                width: 320,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 8),
                    Text(
                      'Gönder',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

class NavigateToRegisterPage extends StatelessWidget {
  const NavigateToRegisterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/register'),
        child: const Text.rich(
          TextSpan(
            text: 'Bir hesabınız yok mu? ',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: 'Kayıt ol',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButtonField extends StatelessWidget {
  const LoginButtonField({
    required this.formKey,
    required this.valueByEmailController,
    required this.valueByPasswordController,
    required this.isTermsAccepted,
    super.key,
  });

  final bool isTermsAccepted;
  final GlobalKey<FormState> formKey;
  final String valueByEmailController;
  final String valueByPasswordController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isTermsAccepted || formKey.currentState!.validate()) {
          // Show loading widget for 2 seconds
          final loadingCompleter = Completer<void>();
          Timer(const Duration(seconds: 2), loadingCompleter.complete);
          showLoadingAnimation(context);

          // Execute sign-in logic after delay
          await loadingCompleter.future;
          await AuthService().signIn(context, email: valueByEmailController, password: valueByPasswordController);
        }
      },
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
              'Giriş Yap',
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
}

class BuildEmailTextField extends StatelessWidget {
  const BuildEmailTextField({
    required this.width,
    required this.height,
    required this.loginViewModel,
    required this.emailController,
    super.key,
  });

  final double width;
  final double height;
  final LoginViewModel loginViewModel;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.82,
      height: height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromRGBO(49, 62, 85, 0.78),
      ),
      child: Center(
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(
              Icons.email_outlined,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                style: TextStyle(color: thirdTextColor),
                keyboardType: TextInputType.emailAddress,
                validator: loginViewModel.validateEmail,
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'E-posta',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
