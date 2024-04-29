part of 'verify_email_view.dart';

mixin VerifyEmailMixin on State<VerifyEmailPage> {
  // Mail svg path
  final String mailSvg = 'assets/images/veritification_mail_sent.svg';

  // Timer variables
  late Timer _timer;
  int _start = 60; // Countdown duration in seconds
  bool _buttonDisabled = true; // To control button state

  //Service
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    startTimer(); // Start the countdown timer when the page is opened
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _authService.checkEmailVerificationStatus(context);
      if (_start == 0) {
        setState(() {
          _buttonDisabled = false; // Enable button when countdown ends
          _timer.cancel(); // Cancel the timer
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void resetTimer() {
    setState(() {
      _start = 60; // Reset the timer duration
      _buttonDisabled = true; // Disable the button
      startTimer(); // Start the countdown timer again
      // You can trigger your email sending function here
      _authService.sendEmailVerification();
    });
  }
}
