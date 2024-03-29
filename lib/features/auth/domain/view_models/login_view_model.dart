class LoginViewModel {
  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'E-posta alanı boş bırakılamaz';
    } else if (value.length < 6) {
      return 'E-posta en az 6 karakter olmalıdır';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Şifre alanı boş bırakılamaz';
    } else if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır';
    }
    return null;
  }
}
